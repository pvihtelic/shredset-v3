class Backcountry

  def self.scrape
    require 'nokogiri'
    require 'open-uri'

    @url = ["http://www.backcountry.com/skis", "http://www.backcountry.com/Store/catalog/categoryLanding.jsp?categoryId=bcsCat5110005&page=1", "http://www.backcountry.com/Store/catalog/categoryLanding.jsp?categoryId=bcsCat5110005&page=2", "http://www.backcountry.com/Store/catalog/categoryLanding.jsp?categoryId=bcsCat5110005&page=3", "http://www.backcountry.com/Store/catalog/categoryLanding.jsp?categoryId=bcsCat5110005&page=4", "http://www.backcountry.com/Store/catalog/categoryLanding.jsp?categoryId=bcsCat5110005&page=5", "http://www.backcountry.com/Store/catalog/categoryLanding.jsp?categoryId=bcsCat5110005&page=6", "http://www.backcountry.com/womens-skis"]
    @links_array = []

    @url.each do |url|
      data = Nokogiri::HTML(open(url))
      out_of_stock = data.css(".out-of-stock").text
      if !out_of_stock.present?
        product_links = data.css("div.product.item-listing a")
        product_links.each do |link|
          @link_strings = "#{link['href']}"
          if @link_strings.blank?
          else
            @links_array << "http://www.backcountry.com#{@link_strings}"
          end
        end
      end
    end

    # puts @links_array

    @store = Store.create(:store_url => "http://www.backcountry.com/", :vendor => "backcountry.com")

    womens_array = ["http://www.backcountry.com/rossignol-temptation-88-ski-womens", "http://www.backcountry.com/armada-tryst-ski-womens", "http://www.backcountry.com/moment-sierra-ski-womens", "http://www.backcountry.com/line-shadow-ski-womens", "http://www.backcountry.com/blizzard-dakota-ski-womens", "http://www.backcountry.com/g3-cake-ski-womens", "http://www.backcountry.com/atomic-millennium-ski-womens", "http://www.backcountry.com/4frnt-skis-madonna-ski-womens", "http://www.backcountry.com/armada-cantika-ski-womens", "http://www.backcountry.com/fischer-koa-98-ski", "http://www.backcountry.com/armada-arw-alpine-ski-womens", "http://www.backcountry.com/fischer-koa-110-ski-womens", "http://www.backcountry.com/salomon-rockette-92-ski-womens", "http://www.backcountry.com/moment-reagan-ski-womens", "http://www.backcountry.com/k2-empress-ski-womens", "http://www.backcountry.com/armada-arvw-alpine-ski-womens", "http://www.backcountry.com/moment-hot-mess-ski-womens", "http://www.backcountry.com/nordica-la-nina-ski-womens", "http://www.backcountry.com/volkl-tierra-ski-w-attiva-motion-ipt-11.0-binding-womens", "http://www.backcountry.com/rossignol-s2-ski-womens", "http://www.backcountry.com/rossignol-attraxion-echo-6-ski-with-wtpi2-sapphire-110-binding", "http://www.backcountry.com/k2-superburnin-ski-w-marker-ers-11.0-tc-binding-womens-k2s0932", "http://www.backcountry.com/scott-rosa-ski-womens"]
    womens_array.each do |link|
      @links_array << link
    end


    @links_array.each do |product_link|
      data = Nokogiri::HTML(open(product_link))

      #brand
      @brand_object = data.css("h1.header-2.product-name").css("span").text.strip.gsub(' Skis','')
      @brand_rename = @brand_object.split(' ')
      @first_word = @brand_rename[0]

      lib_tech = Brand.where(:company => 'Lib Tech').first

      if @first_word == 'Lib' && !lib_tech
        @brand = Brand.create(:company => 'Lib Tech')
      elsif @first_word == 'Lib' && lib_tech
        @brand = Brand.where(:company => 'Lib Tech').first
      elsif Brand.exists?(['company LIKE ?', "%#{@first_word}%"])
        @brand = Brand.where("company LIKE ?", "%#{@first_word}%").first
      else
        @brand = Brand.create(:company => @brand_object)
      end

      brand = Brand.find_or_create_by_company(:company => brand)
      # puts brand.company

      #name
      @scraped_name = data.css(".product-group-title .product-name").text

      name_array = [
        ["Armada El Rey Ski", "El Rey"], 
        ["Dynastar 6th Sense Distorter Ski", "6th Sense Distorter"], 
        ["Dynastar 6th Sense Huge Ski", "6th Sense Huge"],
        ["Dynastar 6th Sense Slicer Ski", "6th Sense Slicer"], 
        ["Dynastar 6th Sense Superpipe Ski", "6th Sense Superpipe"], 
        ["Dynastar Cham 107 Ski", "Cham 107"], 
        ["Dynastar Cham 127 Ski", "Cham 127"], 
        ["Dynastar Cham 87 Ski", "Cham 87"], 
        ["Dynastar Cham 97 Ski", "Cham 97"], 
        ["Dynastar Exclusive Legend Eden Ski - Women's", "Legend Eden"], 
        ["Dynastar Exclusive Legend Paradise Ski - Women's", "Legend Paradise"], 
        ["Fischer Big Stix 110 Ski", "Big Stix 110"], 
        ["Fischer Big Stix 120 Ski", "Big Stix 120"],
        ["Fischer Big Stix 98 Ski", "Big Stix 98"], 
        ["Fischer Koa 110 Ski - Women's", "Fischer Koa 110"], 
        ["Fischer Koa 88 Ski - Women's", "Fischer Koa 88"], 
        ["Fischer Koa 98 Ski - Women's", "Koa 98"], 
        ["Line Celebrity 85 Ski - Women's", "Celebrity 85"], 
        ["Line Celebrity 90 Ski - Women's", "Celebrity 90"], 
        ["Line Influence 105 Ski", "Influence 105"], 
        ["Line Influence 115 Ski", "Influence 115"], 
        ["Line Prophet 85 Ski", "Prophet 85"], 
        ["Line Prophet 90 Ski", "Prophet 90"], 
        ["Line Prophet 98 Ski", "Prophet 98"], 
        ["Line Prophet Flite Ski","Prophet Flite"], 
        ["Moment Belafonte Ski", "Belefonte"],
        ["Rossignol Experience 88 Ski","Experience 88"], 
        ["Rossignol Experience 98 Ski","Experience 98"], 
        ["Rossignol Temptation 82 Ski - Women's","Temptation 82"], 
        ["Rossignol Temptation 88 Ski - Women's","Temptation 88"], 
        ["Salomon BBR 10.0 Ski","BBR 10.0"], 
        ["Salomon BBR 8.0 Ski","BBR 8.0"], 
        ["Salomon BBR 8.9 Ski","BBR 8.9"], 
        ["Salomon BBR Sunlite Ski - Women's","BBR Sunlite"], 
        ["Salomon El Dictator Ski","El Dictator"], 
        ["Salomon Rocker 2 108 Ski","Rocker2 108"], 
        ["Salomon Rocker 2 115 Ski","Rocker2 115"], 
        ["Salomon Rocker 2 122 Ski","Rocker2 122"], 
        ["Salomon Rocker 2 90 Ski","Rocker2 90"], 
        ["Salomon Rocker2 92 Ski","Rocker2 92"], 
        ["Salomon Rockette 115 Ski", "Rockette 115"], 
        ["Salomon Rockette 90 Ski - Women's", "Rockette 90"], 
        ["Salomon Rockette 92 Ski - Women's", "Rockette 92"], 
        ["Scott Jib Ski", "Jib"], 
        ["Scott Jib TW Ski", "Jib TW"]]

      name_array.each do |name_pair|
        if @scraped_name.include?("#{name_pair[0]}")
           @name = "#{name_pair[1]}"
           break
        else
          name_array2 = @scraped_name.split(' ')
          name_array2.delete_at(0)
          nam = name_array2.join " "
          @name = nam.gsub(' Ski', '')
          @name = @name.gsub(' Skis', '')
          @name = @name.gsub('Skis ', '')
          @name = @name.gsub('Diamond ', '')
          @name = @name.gsub('Technologies ', '')
          @name = @name.gsub('USA ', '')
        end
      end
        
      puts @name
      # if name.include?('Binding')
      #   name_array = name.split(' ')
      #   name_array.delete_at(0)
      #   @name = name_array.join " "
      # elsif name.include?('Belafonte Ski')
      #   @name = 'Belefonte'
      # else
      #   name_array = @name.split(' ')
      #   name_array.delete_at(0)
      #   nam = name_array.join " "
      #   @name = nam.gsub(' Ski', '')
      #   @name = @name.gsub(' Skis', '')
      #   @name = @name.gsub('Skis ', '')
      #   @name = @name.gsub('Diamond ', '')
      #   @name = @name.gsub('Technologies ', '')
      #   @name = @name.gsub('USA ', '')
      # end

      # #model year not available

      #description
      @description = data.css(".product-information p").text

      #ability level not available

      #rocker type
      table = data.css(".tech-specs")
      table.search('tr').each do |table|
        headers = table.search('td').text
        if headers.include? "Profile"
          headers2 = headers.dup
          headers2[0..7] = ''
          @rocker_type = headers2
        end
      end


      #ski type
      ski_type = data.css(".breadcrumb .current a").text
      if @name.include?("Binding")
      	@ski_type = "All Mountain Ski Packages"
      elsif ski_type.include? "Big Mountain"
        @ski_type = "Powder Skis"
      elsif ski_type.include? "All Mountain"
        @ski_type = "All Mountain Skis"
      elsif ski_type.include? "Carve"
        @ski_type = "Carving Skis"
      elsif ski_type.include? "Fat"
        @ski_type = "Powder Skis"
      elsif ski_type.include? "Alpine Park"
        @ski_type = "Park & Pipe Skis"
      else @ski_type = "na"
      end

      #gender
      if ski_type.include?("Women's") || if ski_type.include?("Rockette")
        @gender = "Women's"
      else
        @gender = "Men's"
      end

      #price
      @price = data.css(".price-integer, .price-fraction").text.gsub(',','')
      # puts @price

      #image link
      image_href = data.css("#product_image .wraptocenter a")
      image_href.each do |link|
        link2 = link['href'].dup
        link2[0..1] = ''
        @image_link = "http://#{link2}"
      end

      image_link = @image_link

      #average review
      review = data.css(".product-group-title .rating .rating-value").text
      if review == "0"
        @average_review = "na"
      else
        @average_review = review
      end

      #number of reviews
      @number_of_reviews = data.css(".product-group-title .rating-count a").text.scan(/\d/).join ''
      if @number_of_reviews.empty?
        @number_of_reviews = "na"
      end

      #turning radius
      # table = data.css(".tech-specs")
      # table.search('tr').each do |table|
      #   headers = table.search('td').text
      #   if headers.include? "Turn Radius"
      #     headers2 = headers.dup
      #     headers2[0..11] = ''
      #     @turning_radius = headers2
      #   end
      # end

      # puts @turning_radius

      #lengths
      # table = data.css(".tech-specs")
      # table.search('tr').each do |table|
      #   headers = table.search('td').text
      #   if headers.include? "Length"
      #     headers2 = headers.dup
      #     headers2[0..6] = ''
      #     @length= headers2
      #   end
      # end

      #dimensions
      # table = data.css(".tech-specs")
      # table.search('tr').each do |table|
      #   headers = table.search('td').text
      #   if headers.include? "Dimensions"
      #     headers2 = headers.dup
      #     headers2[0..10] = ''
      #     @dimensions = headers2
      #   end
      # end

      #sizes_available
      @sizes = []

      if data.xpath('//option[contains(@data-img-title, "One Color") or contains(@data-img-title, "Black") or contains(@data-img-title, "White") or contains(@data-img-title, "Blue") or contains(@data-img-title, "Purple") or contains(@data-img-title, "Green") or contains(@data-img-title, "Beige") or contains(@data-img-title, "Pink")or contains(@data-img-title, "Orange")or contains(@data-img-title, "Gray")or contains(@data-img-title, "Red")or contains(@data-img-title, "Brown") or contains(@data-img-title, "Pepper") or contains(@data-img-title, "Turquoise") or contains(@data-img-title, "Sand") or contains(@data-img-title, "Corail") or contains(@data-img-title, "Lime")]').text.gsub(/\(.*?\)/, "").scan(/\d{3}/).present?
        @sizes_available_array = data.xpath('//option[contains(@data-img-title, "One Color") or contains(@data-img-title, "Black") or contains(@data-img-title, "White") or contains(@data-img-title, "Blue") or contains(@data-img-title, "Purple") or contains(@data-img-title, "Green") or contains(@data-img-title, "Beige") or contains(@data-img-title, "Pink")or contains(@data-img-title, "Orange")or contains(@data-img-title, "Gray")or contains(@data-img-title, "Red")or contains(@data-img-title, "Brown") or contains(@data-img-title, "Pepper") or contains(@data-img-title, "Turquoise") or contains(@data-img-title, "Sand") or contains(@data-img-title, "Corail") or contains(@data-img-title, "Lime")]').text.gsub(/\(.*?\)/, "").scan(/\d{3}/)
        @sizes_available_array.each do |sizes_available|
          @sizes << sizes_available
        end
      else
        @sizes_available_array = data.xpath('//option[contains(@data-img-title, "cm")]').text.gsub(/\(.*?\)/, "").scan(/\d{3}/)
        @sizes_available_array.each do |sizes_available|
          @sizes << sizes_available
        end
      end

      # puts @sizes

      @product_link = product_link

      if @name.include?("Binding") || @name.include?("Backcountry.com")
          @ski = Ski.create(:name => @name, :ability_level => "na", :description => @description, :gender => @gender, :model_year => "na", :rocker_type => @rocker_type, :ski_type => @ski_type, :brand_id => @brand.id)

          @sizes.each do |size_available|
            Inventory.create(:price => @price, :product_url => @product_link, :ski_id => @ski.id, :size_available => size_available, :store_id => @store.id)
          end

          image = Image.create(:image_url => @image_link, :ski_id => @ski.id)
          # puts image.image_url

          review = Review.create(:average_review => @average_review, :number_of_reviews => @number_of_reviews, :ski_id => @ski.id, :store_id => @store.id)

      # elsif Ski.where(['name LIKE ?', "%#{@name.split(' ')[0]}%"]).exists?
      #     # @ski = Ski.where(:name => @name).first

      #     @ski2 = Ski.where("name LIKE ?", "%#{@name.split(' ')[0]}%").first

      #     @sizes.each do |size_available|
      #       Inventory.create(:price => @price, :product_url => @product_link, :ski_id => @ski2.id, :size_available => size_available, :store_id => @store.id)
      #     end

      #     image = Image.create(:image_url => @image_link, :ski_id => @ski2.id)
      #     # puts image.image_url

      #     review = Review.create(:average_review => @average_review, :number_of_reviews => @number_of_reviews, :ski_id => @ski2.id, :store_id => @store.id)
      elsif Ski.where(:name => @name).exists?
        @ski7 = Ski.where(:name => @name).first

          @sizes.each do |size_available|
            Inventory.create(:price => @price, :product_url => @product_link, :ski_id => @ski7.id, :size_available => size_available, :store_id => @store.id)
          end

          image = Image.create(:image_url => @image_link, :ski_id => @ski7.id)
          # puts image.image_url

          review = Review.create(:average_review => @average_review, :number_of_reviews => @number_of_reviews, :ski_id => @ski7.id, :store_id => @store.id)
      else
          @ski3 = Ski.create(:name => @name, :ability_level => "na", :description => @description, :gender => @gender, :model_year => "na", :rocker_type => @rocker_type, :ski_type => @ski_type, :brand_id => @brand.id)

          @sizes.each do |size_available|
            Inventory.create(:price => @price, :product_url => @product_link, :ski_id => @ski3.id, :size_available => size_available, :store_id => @store.id)
          end

          image = Image.create(:image_url => @image_link, :ski_id => @ski3.id)
          # puts image.image_url

          review = Review.create(:average_review => @average_review, :number_of_reviews => @number_of_reviews, :ski_id => @ski3.id, :store_id => @store.id)
          # puts review.average_review
      end
      end
    end
  end
end  