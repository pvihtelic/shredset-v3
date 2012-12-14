class Evo

  def self.scrape
    require 'nokogiri'
    require 'open-uri'

    @url = ["http://www.evo.com/shop/ski/skis.aspx", "http://www.evo.com/a-shop/ski/skis/p_2.aspx", "http://www.evo.com/a-shop/ski/skis/p_3.aspx", "http://www.evo.com/a-shop/ski/skis/p_4.aspx", "http://www.evo.com/a-shop/ski/skis/p_5.aspx", "http://www.evo.com/a-shop/ski/skis/p_6.aspx", "http://www.evo.com/a-shop/ski/skis/p_7.aspx", "http://www.evo.com/a-shop/ski/skis/p_8.aspx", "http://www.evo.com/a-shop/ski/skis/p_9.aspx", "http://www.evo.com/a-shop/ski/skis/p_10.aspx", "http://www.evo.com/a-shop/ski/skis/p_11.aspx", "http://www.evo.com/a-outlet-shop/ski/skis.aspx", "http://www.evo.com/a-outlet-shop/ski/skis/p_2.aspx", "http://www.evo.com/a-outlet-shop/ski/skis/p_3.aspx", "http://www.evo.com/a-outlet-shop/ski/skis/p_4.aspx", "http://www.evo.com/a-outlet-shop/ski/skis/p_5.aspx"]

    @links_array = []

    @url.each do |url|
      data = Nokogiri::HTML(open(url))
      product_links = data.css("div.product.item.hproduct a")
      product_links.each do |link|
        @link_strings = "#{link['href']}"
        if @link_strings.blank?
        else
          @links_array << "http://www.evo.com#{@link_strings}"
        end
      end
    end

    @store = Store.create(:store_url => "http://www.evo.com/", :vendor => "evo.com")

    @links_array.each do |product_link|
      data = Nokogiri::HTML(open(product_link))
      if !data.css("#detailsPage div.OutOfStock h2").present?
        brand = data.css("h1.fn").css("strong.brand").text.gsub(' Skis','')
        brand = Brand.find_or_create_by_company(:company => brand)
        # puts brand.company
        initial_name = data.at('strong').next.text
        if initial_name.include? "Binding"
          name = initial_name.gsub(" Skis", '')
          name = name.gsub("2012", '')
          name = name.gsub("2013", '')
        else
          name = initial_name.slice(1...(initial_name.index(' Skis')))
        end

        puts name

        model_year = data.css("h1.fn").text.gsub(/[^\d]/,"").slice(-4..-1).to_i
        description = data.css(".description").text

        ability_level_input = data.at_css('span.values').text
        ability_level = if ability_level_input.include?("Beginner-Intermediate")
        "Beginner"
      elsif ability_level_input.include?("Intermediate-Advanced")
        "Intermediate"
      elsif ability_level_input.include?("Advanced-Expert")
        "Expert"
      else 
        "na"
      end

      rocker_type = data.xpath('//span[contains(text(), "Rocker Type")]').first.next_element.text

      if !data.xpath('//span/a[contains(@href, "/all-mountain.aspx")]').text.empty?
        ski_type = data.xpath('//span/a[contains(@href, "/all-mountain.aspx")]').text
      elsif !data.xpath('//span/a[contains(@href, "/powder.aspx")]').text.empty?
        ski_type = "Big Mountain Skis"
      elsif !data.xpath('//span/a[contains(@href, "/twin-tip.aspx")]').text.empty?
        ski_type = "Big Mountain Skis"
      elsif !data.xpath('//span/a[contains(@href, "/park-pipe.aspx")]').text.empty?
        ski_type = "Park & Pipe Skis"
      elsif !data.xpath('//span/a[contains(@href, "/alpine-touring.aspx")]').text.empty?
        ski_type = "Alpine Touring Skis"
      elsif !data.xpath('//span/a[contains(@href, "/carving.aspx")]').text.empty?
        ski_type = "Carving Skis"
      else
        ski_type = "na"
      end

      if data.css("h1.fn").text.include? "Women's"
        gender = "Women's"
      elsif data.css("h1.fn").text.include? "Youth"
        gender = "Youth"
      else
        gender = "Men's"
      end

      @price = data.css("#price").text.strip.gsub('$','').gsub(',','')
      # puts @price

      image_link_relative = data.css(".mainImageContainer").map{|link| link['href']}
      image_link = "http://www.evo.com#{image_link_relative.join}"
      # puts image_link

      average_review_object = data.css(".average").text.to_i
      if average_review_object > 0
        average_review = average_review_object*19 + rand(6)
      else
        average_review = 0
      end

      review_object = data.css(".pr-snapshot-average-based-on-text").text.gsub(/[^\d]/,"").to_i
      if !review_object.blank?
        number_of_reviews = review_object
      else
        number_of_reviews = "na"
      end

      specs = []
      data.xpath('//table[@class="matrixSpecTable"]//thead/th').search('th').map(&:to_s).each_with_index do |th, i|

        if i == 0
          next
        else
          specs << { :length => th.slice(/\d+/).to_i }
        end
      end

      spec_labels = {
        'Turning Radius (m)' => :turning_radius,
        'Tip Width (mm)' => :tip_width,
        'Waist Width (mm)' => :waist_width,
        'Tail Width (mm)' => :tail_width,
        'Indv. Ski Weight (g)' => :weight,
        'Weight (g)' => :weight
      }

      data.xpath('//table[@class="matrixSpecTable"]//tr').each do |tr|
        @key = :something

        tr.search('td').each_with_index do |td, i|
          if i == 0
            @key = spec_labels[td.text]
          else
            specs[i-1][@key] = td.text.to_i
          end
        end
      end

      @sizes = []
      @placeholder = []
      @sizes_available_array = data.at_css('.buttonContainer').text.strip.scan(/\d*/)
      @placeholder << @sizes_available_array.select{|string| string.length == 3}
      @placeholder.each do |placeholder_object|
        @sizes << placeholder_object
      end

      @ski = Ski.create(:name => name, :ability_level => ability_level, :description => description, :gender => gender, :model_year => model_year, :rocker_type => rocker_type, :ski_type => ski_type, :brand_id => brand.id)

      specs.each do |spec|
        spec[:ski_id] = @ski.id
        @sizes[0].each do |size|
          if spec[:length] == size.to_i
            spec[:size_available] = true
          end
        end
        Spec.create(spec)
      end

      @product_link = product_link

      @sizes[0].each do |size_available|
        Inventory.create(:price => @price, :product_url => @product_link, :ski_id => @ski.id, :size_available => size_available, :store_id => @store.id)
      end

      image = Image.create(:image_url => image_link, :ski_id => @ski.id)

      if average_review > 0
        review = Review.create(:average_review => average_review, :number_of_reviews => number_of_reviews, :ski_id => @ski.id, :store_id => @store.id)
      end 

    end
    # puts @ski.name
  end
end
end