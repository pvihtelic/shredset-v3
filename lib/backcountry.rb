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

    womens_array = ["http://www.backcountry.com/rossignol-temptation-88-ski-womens", "http://www.backcountry.com/armada-tryst-ski-womens", "http://www.backcountry.com/moment-sierra-ski-womens", "http://www.backcountry.com/line-shadow-ski-womens", "http://www.backcountry.com/blizzard-dakota-ski-womens", "http://www.backcountry.com/g3-cake-ski-womens", "http://www.backcountry.com/atomic-millennium-ski-womens", "http://www.backcountry.com/4frnt-skis-madonna-ski-womens", "http://www.backcountry.com/armada-cantika-ski-womens", "http://www.backcountry.com/fischer-koa-98-ski", "http://www.backcountry.com/armada-arw-alpine-ski-womens", "http://www.backcountry.com/fischer-koa-110-ski-womens", "http://www.backcountry.com/salomon-rockette-92-ski-womens", "http://www.backcountry.com/moment-reagan-ski-womens", "http://www.backcountry.com/k2-empress-ski-womens", "http://www.backcountry.com/armada-arvw-alpine-ski-womens", "http://www.backcountry.com/moment-hot-mess-ski-womens", "http://www.backcountry.com/nordica-la-nina-ski-womens", "http://www.backcountry.com/volkl-tierra-ski-w-attiva-motion-ipt-11.0-binding-womens", "http://www.backcountry.com/rossignol-s2-ski-womens", "http://www.backcountry.com/rossignol-attraxion-echo-6-ski-with-wtpi2-sapphire-110-binding", "http://www.backcountry.com/k2-superburnin-ski-w-marker-ers-11.0-tc-binding-womens-k2s0932"]
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

      # puts brand.company

      #name
      @scraped_name = data.css(".product-group-title .product-name").text

     #ski type
      ski_type = data.css(".breadcrumb .current a").text
      if @scraped_name.include?("Binding")
        @ski_type = "All Mountain Ski Packages"
      elsif ski_type.include? "Big Mountain"
        @ski_type = "Big Mountain Skis"
      elsif ski_type.include? "All Mountain"
        @ski_type = "All Mountain Skis"
      elsif ski_type.include? "Carve"
        @ski_type = "Carving Skis"
      elsif ski_type.include? "Fat"
        @ski_type = "Big Mountain Skis"
      elsif ski_type.include? "Alpine Park"
        @ski_type = "Park & Pipe Skis"
      else @ski_type = "na"
      end

      #gender
      if(ski_type.include?("Women's") || ski_type.include?("Rockette") || @scraped_name.include?("Women"))
        @gender = "Women's"
      else
        @gender = "Men's"
      end

      name_array = [
        ["Armada El Rey Ski", "El Rey"], 
        ["Aretha Ski - Women", "Aretha"],
        ["ARVw Ski - Women", "ARVw"],
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
        ["Element Ski - Women", "Element"],
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
        ["Madonna Ski - Women", "Madonna"],
        ["Millennium Ski - Women", "Millennium"],
        ["Moment Belafonte Ski", "Belefonte"],
        ["Rossignol Experience 88 Ski","Experience 88"], 
        ["Rossignol Experience 98 Ski","Experience 98"], 
        ["Rossignol Temptation 82 Ski - Women's","Temptation 82"], 
        ["Rossignol Temptation 88 Ski - Women's","Temptation 88"], 
        ["Samba Ski - Women", "Samba"],
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
        ["Scott Jib TW Ski", "Jib TW"],
        ["AMP", "AMPerge"],
        ["Aura Ski - Women", "Aura" ],
        ["VJJ Ski - Women", "VJJ"],
        ["TSTw Ski - Women", "TSTw"],
        ["Cantika Ski - Women", "Cantika"],
        ["Century Ski - Women", "Century"],
        ["Cody", "CODY"],
        ["DarkSide", "Darkside"],
        ["Deathwish", "Death Wish"],
        ["Empress Ski - Women", "Empress"],
        ["Pandora Ski - Women", "Pandora"],
        ["Soulmate Ski - Women", "Soulmate"],
        ["SuperSweet Ski with Marker ER3 10.0 Binding - Women", "SuperSweet + Marker ER3 10.0 Bindings - Women's"],
        ["SuperStitious Ski with Marker ERS 11.0 TC Binding - Women", "SuperStitious + Marker ERS 11.0 TC Bindings - Women's"],
        ["Superific Ski with Marker ER3 10.0 Binding - Women", "SuperIfic + Marker ER3 10.0 Bindings - Women's"],
        ["SuperGlide Ski with Marker ERS 11.0 TC Binding - Women", "SuperGlide + Marker ERS 11.0 TC Bindings - Women's"],
        ["SuperFree Ski with Marker ER3 10.0 Binding - Women", "SuperFree + Marker ER3 10.0 Bindings - Women's"],
        ["Enforcer Ti", "Enforcer"],
        ["SuperBurnin Ski with Marker ERS 11.0 TC Binding - Women", "SuperBurnin + Marker ERS 11.0 TC Bindings - Women's"],
        ["Sierra Ski - Women", "Sierra"],
        ["SideKick Ski - Women", "SideKick"],
        ["Shadow Ski - Women", "Shadow"],
        ["Samba Ski - Women", "Samba"],
        ["S7 Ski - Women", "S7"],
        ["S3 Ski - Women", "S3"],
        ["S2 Ski - Women", "S2"],
        ["S7", "S7"],
        ["RTM 84 with IPT Wideride 12.0 D Binding", "RTM 84 + iPT Wide Ride 12.0 Bindings"],
        ["Nemesis Ski - Women", "Nemesis"],
        ["Freeride NAS reCurve", "Freeride NAS ReCurve"],
        ["MissDemeanor Ski - Women", "MissDemeanor"], 
        ["MissConduct Ski - Women", "MissConduct"], 
        ["MissBehaved Ski - Women", "MissBehaved"],
        ["MissDirected Ski - Women", "MissDirected"],
        ["Fully Functional Five NAS", "Fully Functional Five ReCurve"],
        ["Geisha 100 Ski - Women", "Geisha 100"],
        ["Hell and Back", "Hell & Back"],
        ["Hot Mess Ski - Women", "Hot Mess"],
        ["Madonna Ski - Women", "Madonna"],
        ["Kenja Ski - Women", "Kenja"],
        ["Kiku Ski - Women", "Kiku"]]

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
      review = data.css(".product-group-title .rating .rating-value").text.to_i
      if review > 0
        @average_review = review*19 + rand(6)
      else
        @average_review = 0
      end

      #number of reviews
      @number_of_reviews = data.css(".product-group-title .rating-count a").text.scan(/\d/).join('').to_i
      if @number_of_reviews.blank?
        @number_of_reviews = 0
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

      @model_year = 2013

      @product_link = product_link

      if @name.include?("Binding") || @name.include?("Backcountry.com")
          @ski = Ski.create(:name => @name, :ability_level => "na", :description => @description, :gender => @gender, :model_year => @model_year, :rocker_type => @rocker_type, :ski_type => @ski_type, :brand_id => @brand.id)

          @sizes.each do |size_available|
            Inventory.create(:price => @price, :product_url => @product_link, :ski_id => @ski.id, :size_available => size_available, :store_id => @store.id)
          end

          image = Image.create(:image_url => @image_link, :ski_id => @ski.id)

          if @average_review > 0
            review = Review.create(:average_review => @average_review, :number_of_reviews => @number_of_reviews, :ski_id => @ski.id, :store_id => @store.id)
          end
      elsif Ski.where(:name => @name).exists?
        if Ski.where(:name => @name).where(:model_year => @model_year).where(:gender => @gender).exists?

          @ski8 = Ski.where(:name => @name).where(:model_year => @model_year).where(:gender => @gender).first
          
         
            @sizes.each do |size_available|
              Inventory.create(:price => @price, :product_url => @product_link, :ski_id => @ski8.id, :size_available => size_available, :store_id => @store.id)
            end

            image = Image.create(:image_url => @image_link, :ski_id => @ski8.id)

            if @average_review > 0
              review = Review.create(:average_review => @average_review, :number_of_reviews => @number_of_reviews, :ski_id => @ski8.id, :store_id => @store.id)
            end

        else
          @ski2 = Ski.create(:name => @name, :ability_level => "na", :description => @description, :gender => @gender, :model_year => @model_year, :rocker_type => @rocker_type, :ski_type => @ski_type, :brand_id => @brand.id)

          @sizes.each do |size_available|
            Inventory.create(:price => @price, :product_url => @product_link, :ski_id => @ski2.id, :size_available => size_available, :store_id => @store.id)
          end

          image = Image.create(:image_url => @image_link, :ski_id => @ski2.id)
          
          if @average_review > 0
            review = Review.create(:average_review => @average_review, :number_of_reviews => @number_of_reviews, :ski_id => @ski2.id, :store_id => @store.id)    
        end
        
        end  
      else
          @ski3 = Ski.create(:name => @name, :ability_level => "na", :description => @description, :gender => @gender, :model_year => @model_year, :rocker_type => @rocker_type, :ski_type => @ski_type, :brand_id => @brand.id)

          @sizes.each do |size_available|
            Inventory.create(:price => @price, :product_url => @product_link, :ski_id => @ski3.id, :size_available => size_available, :store_id => @store.id)
          end

          image = Image.create(:image_url => @image_link, :ski_id => @ski3.id)
          # puts image.image_url

          if @average_review > 0
            review = Review.create(:average_review => @average_review, :number_of_reviews => @number_of_reviews, :ski_id => @ski3.id, :store_id => @store.id)
          end  
      end
      end
    end
end  