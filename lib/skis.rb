class Skis

	def self.scrape
		require 'nokogiri'
		require 'open-uri'

		@urls = ["http://www.skis.com/skis/100,default,sc.html?start=0&sz=24", "http://www.skis.com/skis/100,default,sc.html?start=24&sz=24", "http://www.skis.com/skis/100,default,sc.html?start=48&sz=24", "http://www.skis.com/skis/100,default,sc.html?start=72&sz=24", "http://www.skis.com/skis/100,default,sc.html?start=96&sz=24", "http://www.skis.com/skis/100,default,sc.html?start=120&sz=24", "http://www.skis.com/skis/100,default,sc.html?start=144&sz=24", "http://www.skis.com/skis/100,default,sc.html?start=168&sz=24", "http://www.skis.com/skis/100,default,sc.html?start=192&sz=24", "http://www.skis.com/skis/100,default,sc.html?start=216&sz=24", "http://www.skis.com/skis/100,default,sc.html?start=240&sz=24", "http://www.skis.com/skis/100,default,sc.html?start=264&sz=24", "http://www.skis.com/skis/100,default,sc.html?start=288&sz=24", "http://www.skis.com/skis/100,default,sc.html?start=312&sz=24", "http://www.skis.com/skis/100,default,sc.html?start=336&sz=24", "http://www.skis.com/skis/100,default,sc.html?start=360&sz=24", "http://www.skis.com/skis/100,default,sc.html?start=384&sz=24", "http://www.skis.com/skis/100,default,sc.html?start=408&sz=24", "http://www.skis.com/skis/100,default,sc.html?start=432&sz=24", "http://www.skis.com/skis/100,default,sc.html?start=456&sz=24", "http://www.skis.com/skis/100,default,sc.html?start=480&sz=24", "http://www.skis.com/skis/100,default,sc.html?start=504&sz=24", "http://www.skis.com/skis/100,default,sc.html?start=528&sz=24"	]

		@links_array = []
		@urls.each do |url| 
			data = Nokogiri::HTML(open(url))
			product_links = data.css(".productlisting .product .name a")
			product_links.each do |link|
				@link_string = "#{link['href']}"
				@links_array << @link_string
			end
		end


		@store = Store.create(:store_url => "http://www.skis.com/", :vendor => "skis.com")

		@links_array.each do |product_link|
			@url2 = product_link
			data = Nokogiri::HTML(open(@url2))

			sizes_available_array = data.css(".swatchanchor").text.gsub("cm", " ").split(' ')
			@sizes = sizes_available_array.map(&:to_i)
		
			#brand
			brand_text = data.css(".productdetail h1.productname").text
			if brand_text.include? "4 FRNT"
				@brand = "4FRNT"
			elsif brand_text.include? "5th Element"
				@brand = brand_text.slice(/(5th Element)/)
			elsif brand_text.include? "Black Diamond"
				@brand = brand_text.slice(/(Black Diamond)/)
			elsif brand_text.include? "Crazy Creek"
				@brand = brand_text.slice(/(Crazy Creek)/)
			elsif brand_text.include? "Epic Planks"
				@brand = brand_text.slice(/(Epic Planks)/)
			elsif brand_text.include? "Hyper Flex"
				@brand = brand_text.slice(/(Hyper Flex)/)
			elsif brand_text.include? "Lucky Bums"
				@brand = brand_text.slice(/(Lucky Bums)/)
			elsif brand_text.include? "P Tech"
				@brand = brand_text.slice(/(P Tech)/)
			elsif brand_text.include? "SA Snowblades"
				@brand = brand_text.slice(/(SA Snowblades)/)
			elsif brand_text.include? "Snow Carve"
				@brand = brand_text.slice(/(Snow Carve)/)
			elsif brand_text.include? "South Line"
				@brand = brand_text.slice(/(South Line)/)
			elsif brand_text.include? "KASTLE"
				@brand = "Kastle"
			elsif brand_text.include? "Lib Tech"
				@brand = "Lib Tech"
			elsif brand_text.include? "Scott Jib TW"
				@brand = "Scott"
			elsif brand_text.include? "Boarder"
				@brand = "Boarder"		
			else
				brand_array = brand_text.split ' '
				@brand = brand_array[0]
			end
			
			if @brand == 'Ski'
			else
				@brand_final = Brand.find_or_create_by_company(:company => @brand)
     	end

			#name
			name = data.css(".productdetail h1.productname").text
			if name.include? "4 FRNT"
				@name = name.gsub("4 FRNT", "")
			elsif name.include? "5th Element"
				@name = name.gsub("5th Element", "")
			elsif name.include? "Black Diamond"
				@name = name.gsub("Black Diamond", "")
			elsif name.include? "Crazy Creek"
				@name = name.gsub("Crazy Creek", "")
			elsif name.include? "Epic Planks"
				@name = name.gsub("Epic Planks", "")
			elsif name.include? "Hyper Flex"
				@name = name.gsub("Hyper Flex", "")
			elsif name.include? "Lucky Bums"
				@name = name.gsub("Lucky Bums", "")
			elsif name.include? "P Tech"
				@name = name.gsub("P Tech", "")
			elsif name.include? "SA Snowblades"
				@name = name.gsub("SA Snowblades", "")
			elsif name.include? "Snow Carve"
				@name = name.gsub("Snow Carve", "")
			elsif name.include? "South Line"
				@name = name.gsub("South Line", "")
			elsif name.include? "Amp Skis"
				@name = "AMPerge"
			else
				name_array = name.split ' '
				name_array.delete_at(0)
				name_array.delete_at(-1)
				@name = name_array.join ' '
			end

      if !@name.include?("Binding")
      	@name = @name.gsub("Skis", "")
      	@name = @name.gsub("2012", "")
      	@name = @name.gsub("2013", "")
      end

      name_array2 = [["A.M.P. Charger Skis with K2/Marker MX 12.0 Bindings", "A.M.P. Charger + MX 12.0 Demo Bindings"],
			["A.M.P. Force Skis with K2/Marker M3 10.0 Bindings", "A.M.P. Force + Marker M3 10.0 Bindings"],
			["A.M.P. Impact Skis with K2/Marker MX 11.0 TC Bindings", "A.M.P. Impact + Marker MX 11.0 TC Bindings"],
			["A.M.P. Photon Skis with K2/Marker M3 10.0 Bindings", "A.M.P. Photon + Marker M3 10.0 Bindings"],
			["A.M.P. Rictor Skis with Marker MX 12.0 Bindings", "A.M.P. Rictor + MX 12.0 Bindings 2011"],
			["Access", "Access"],
			["Ace of Spades Ti", "Ace Of Spades Ti"],
			["Exclusive Active Light", "Exclusive Active Light Womens Skis with XPress10 Bindings"],
			["Adora Womens Skis with Marker 3 Motion 10.0 TP Essenza Bindings", "Adora + Essenza 3Motion TP 10.0 Bindings - Women's"],
			["Affinity Air Womens Skis with XTE 10 Lady Bindings", "Affinity Air + XTE 10 Bindings - Women's"],
			["Affinity Pure Womens Skis with XTO 10 AF Bindings", "Affinity Pure + XTO 10 Bindings - Women's"],
			["Affinity Storm Womens Skis with XTO 10 AF Bindings", "Affinity Storm + XTO 10 Bindings - Women's"],
			["Afterbang Shorty", "Afterbang Shorty"],
			["Afterbang", "Afterbang"],
			["AK JJ", "AK JJ"],
			["Alibi", "Alibi"],
			["Alley", "Alley"],
			["Allura Womens Skis with Marker iPT eMotion 11.0 TC Bindings", "Allura with iPT eMotion 11.0 TC Binding - Women's"],
			["Alpha 1", "Alpha 1"],
			["AR7", "AR7"],
			["ARVw Womens", "ARVw"],
			["ARV", "ARV"],
			["ARW Womens", "ARW - Womens"],
			["Aura Womens", "Aura"],
			["Aurena Womens Skis with Marker 4 Motion 10.0 Essenza Bindings", "Aurena + Essenza 4Motion 10.0 Bindings - Women's"],
			["Automatic", "Automatic"],
			["Axana XCT Womens Skis with N Sport EVO Bindings", "Axana + N Sport Bindings - Women's"],
			["BackDrop", "BackDrop"],
			["Bad Apple Kids", "Bad Apple"],
			["Bad Seed Kids", "Bad Seed"],
			["Bantam Kids", "Bantam"],
			["BBR 10.0", "BBR 10.0"],
			["BBR 8.0", "BBR 8.0"],
			["BBR 8.9", "BBR 8.9"],
			["BBR Sunlite Womens", "BBR Sunlite"],
			["Bent Chetler Mini Kids", "Bent Chetler Mini"],
			["Bent Chetler", "Bent Chetler"],
			["Blackeye Ti Skis with XTO 12 Bindings", "Blackeye Ti + XTO 12 Bindings"],
			["Blend", "Blend"],
			["Blog", "Blog"],
			["BMX 108", "BMX108"],
			["BMX 88", "BMX88"],
			["BMX 98", "BMX98"],
			["Bodacious", "Bodacious"],
			["Bridge", "Bridge"],
			["Bubba", "Bubba"],
			["Bushwacker", "Bushwacker"],
			["Cantika Womens", "Cantika"],
			["Celebrity 85 Womens", "Celebrity 85"],
			["Celebrity 90 Womens", "Celebrity 90"],
			["Century Jr II Kids", "Century Jr. II"],
			["Century", "Century"],			
			["Cham 107", "Cham 107"],
			["Cham 87", "Cham 87"],
			["Cham 97", "Cham 97"],
			["Charisma Womens Skis with Marker iPT eMotion 11.0 TC Essenza Bindings", "Charisma + iPT eMotion 11.0 Bindings - Women's"],
			["Chiara Womens Skis with Marker 4 Motion 11.0 TC Essenza Bindings", "Chiara + Essenza 4Motion 11.0 TC Bindings - Women's"],
			["Chica Jr 7.0 Kids Skis with Marker 3 Motion 7.0 Bindings", "Chica Jr + 3Motion 7.0 Bindings - Youth"],
			["Chronic", "Chronic"],
			["Cochise", "Cochise"],
			["Coda Kids", "Coda"],
			["Colt Skis with XTO 10 Bindings", "Colt + XTO 10 Bindings"],
			["CoomBack", "COOMBAck"],
			["Crimson Ti Skis with XTO 12 Bindings", "Crimson Ti + XTO 12 Bindings"],
			["Czar", "Czar"],
			["Da Nollie", "Da'Nollie"],
			["Dakota Womens", "Dakota - Women's"],
			["Domain", "Domain"],
			["Dozer", "Dozer"],
			["El Rey", "El Rey"],
			["Elysian Womens", "Elysian - Women's"],
			["Empress Womens", "Empress"],
			["Enduro RXT 800 Skis with Z12 B80 Bindings", "Enduro RXT 800 + Z12 Bindings"],
			["Enduro XT 800 Skis with Z12 B80 Bindings", "Enduro XT 800 + Z12 Bindings"],
			["Enduro XT 850 Skis with Z12 B90 Bindings", "Enduro XT 850 + Z12 Bindings"],
			["Experience 74 Skis with Xelium 100 Bindings", "Experience 74 + Xelium 100 Bindings"],
			["Experience 83 Skis with TPX Axium 120 L Bindings", "Experience 83 + Axium 120 Bindings"],
			["Experience 88 Skis with Axium 120 Bindings", "Experience 88 + Axium 120 Bindings"],
			["Experience 88", "Experience 88"],
			["Experience 98", "Experience 98"],
			["Geisha 100 Womens", "Geisha 100"],
			["Gotama Jr. Kids", "Gotama Jr"],
			["Gotama", "Gotama"],			
			["Gunsmoke", "Gunsmoke"],
			["Gypsy", "Gypsy"],
			["Halo", "Halo"],
			["Hard Side", "HardSide"],
			["Hells Belles Womens", "Hell's Belles - Women's"],
			["Highball", "Highball"],
			["Hot Rod Jet Fuel I-Core XBi CT Skis with N Pro 2S Xbi CT WB Bindings", "Hot Rod Jet Fuel I-Core + XBI CT Bindings"],
			["Hot Rod Tempest XBi CT Skis with EXP 2S Xbi CT WB Bindings", "Hot Rod Tempest + XBI CT Bindings"],
			["Hybrid 8.0", "Hybrid 8.0"],
			["Indy Kids", "Indy"],
			["Indy 4.5 Kids Skis with Marker Fastrak 2 4.5 Bindings", "Indy + Marker Fastrak2 4.5 Bindings - Youth - Boy's"],
			["Indy 7.0 Kids Skis with Marker Fastrak 2 7.0 Bindings", "Indy + Marker Fastrak2 7.0 Bindings - Youth - Boy's"],
			["Infidel", "Infidel"],
			["Influence 105", "Influence 105"],
			["Influence 115", "Influence 115"],
			["Iron Maiden", "Iron Maiden"],
			["Jib TW", "Jib TW"],
			["Jib", "Jib"],			
			["JJ", "JJ"],
			["Keeper", "Keeper"],
			["Kendo", "Kendo"],
			["Kenja Womens", "Kenja"],
			["Kink Jr. Kids", "Kink Jr"],
			["Kink", "Kink"],			
			["KOA Jr. Kids Skis with FJ 4 Bindings", "Koa Jr + FJ4 AC Jr Rail Bindings - Youth - Girl's"],
			["KOA jr Kids Skis with FJ 7 Bindings", "Koa Jr + FJ7 AC Jr Rail Bindings - Youth - Girl's"],
			["Kung Fujas", "Kung Fujas"],
			["Ledge", "Ledge"],
			["Luv Bug Girls", "Luv Bug"],
			["Magic J", "Magic J"],
			["Magnum 7.6 IQ Skis with IQ TC 11 Bindings", "Magnum 7.6 IQ + IQ TP 11 Bindings"],
			["Magnum 8.5 Ti", "Magnum 8.5 Ti"],
			["Makai Kids", "Makai"],
			["Manhattan", "Mantra"],
			["Mantra", "Mantra"],
			["Mastermind", "Mastermind"],
			["Millennium", "Millennium"],
			["Missbehaved", "MissBehaved"],
			["Missconduct", "Womens  MissConduct"],
			["Missdemeanor", "Womens MissDemeanor"],
			["Missdirected", "MissDirected"],
			["Missy Kids", "Missy"],
			["Mr. Pollard's Opus", "Mr. Pollard's Opus"],
			["Nemesis Womens", "Nemesis"],
			["Nomad RKR", "Nomad RKR"],
			["Norwalk", "Norwalk"],
			["Oracle Womens", "Oracle"],
			["Origins Lagoon Womens Skis with L9 B80 Bindings", "Origins Lagoon + L9 Bindings - Women's"],
			["Outland 80 Pro Skis with PX Fluid Bindings", "Outland 80 Pro + PX 12 Fluid Bindings"],
			["Pandora", "Pandora"],
			["Panic", "Panic"],
			["Patron", "Patron"],
			["Pettitor", "Pettitor"],
			["Pilgrim", "Pilgrim"],
			["Pipe Cleaner", "Pipe Cleaner"],
			["Pon2oon", "Pon2oon"],
			["Press", "Press"],
			["Prophet 85", "Prophet 85"],
			["Prophet 90", "Prophet 90"],
			["Prophet 98", "Prophet 98"],
			["Prophet Flite", "Prophet Flite"],
			["Punisher", "Punisher"], 
			["Punx Jr III", "Punx Jr III"],
			["Punx", "Punx"],
			["Pursuit HP Skis with Axial 2 140 Ti Bindings", "Pursuit HP + Axial2 140 Ti Bindings"],
			["Pyra Womens", "Pyra"],
			["Ritual", "Ritual"],
			["Rocker 2 108", "Rocker2 108"],
			["Rocker 2 115", "Rocker2 115"],
			["Rocker 2 122", "Rocker2 122"],
			["Rocker 2 90", "Rocker2 90"],
			["Rocker 92", "Rocker2 92"],
			["Rockette 115", "Rockette 115"],
			["Rockette 90 Womens", "Rockette 90"],
			["Rosa Womens", "Rosa - Women's"],
			["RTM 80 Skis with Marker iPT Wideride 12 Bindings", "RTM 80 + iPT Wide Ride 12.0 Bindings"],
			["RTM 84 Skis with Marker iPT Wideride 12.0 Bindings", "RTM 84 + iPT Wide Ride 12.0 Bindings"],
			["S3 W Womens", "S3"],
			["S7 Pro Kids", "S7 Pro"],
			["S7", "S7"],
			["Samba Womens", "Samba"],
			["Savage Ti Skis with XTO 14 Bindings", "Savage Ti + XTO 14 Bindings"],
			["Scimitar Jr X70 Kids", "Scimitar Jr X70 Kids with Xelium Jr 70 Bindings"],
			["Scimitar Jr Kids with Comp Kid 25 L Bindings", "Scimitar Jr Kids with Comp Kid 25 L Bindings"],
			["Scimitar Jr Kids Skis with Xelium Kid 45 Bindings", "Scimitar Jr - Xelium Kid 45 Bindings - Youth - Boy's"],
			["Scimitar", "Scimitar"],
			["Seeker", "Seeker"],
			["Shadow Womens", "Shadow"],
			["Shaman", "Shaman"],
			["Shiro Jr. Kids", "Shiro Jr"],
			["Shiro", "Shiro"],			
			["Shogun 100", "Shogun 100"],
			["Sickle", "Sickle"],
			["SideSeth", "SideSeth"],
			["SideStash", "SideStash"],
			["Sight", "Sight"],
			["Sir Francis Bacon Shorty Kids", "Sir Francis Bacon Shorty"],
			["Sir Francis Bacon", "Sir Francis Bacon"],
			["Smash 7", "Smash 7"],
			["Smoke Skis with XTO 10 Bindings", "Smoke + XTO 10 Bindings"],
			["Smoke Ti Skis with XTO 12 Bindings", "Smoke Ti + XTO 12 Bindings"],
			["Snow Angel Kids", "Snow Angel"],
			["Soulmate Womens", "SoulMate"],
			["Sprayer Pro Kids", "Sprayer Pro"],
			["Sprayer", "Sprayer"],
			["Stepup", "Stepup"],
			["Storm", "Storm"],
			["Super 7", "Super 7"],
			["Super Hero Kids", "Super Hero"],
			["SuperFree Womens Skis with K2/Marker ER3 10.0 Bindings", "SuperFree + Marker ER3 10.0 Bindings - Women's"],
			["SuperGlide Womens Skis with Marker/K2 ERS 11.0 TC Bindings", "SuperGlide + Marker ERS 11.0 TC Bindings - Women's"],
			["SuperIfic Womens Skis with K2/Marker ER3 10.0 Bindings", "SuperIfic + Marker ER3 10.0 Bindings - Women's"],
			["Supreme Womens", "Supreme"],
			["Suspect", "Suspect"],
			["T-hall", "T Hall"],
			["Temptation 78 Womens Skis with Xelium Saphir 110 L Bindings", "Tempation 78 + Xelium Saphir 110 Bindings - Women's"],
			["Temptation 88 Womens", "Temptation 88"],
			["The 130", "The 130"],
			["Theory", "Theory"],
			["Threat", "Threat"],
			["Tonic", "Tonic"],
			["Traveling Circus", "Traveling Circus"],
			["Triple J Kids", "Triple J"],
			["Triumph", "Triumph"],
			["Trooper", "Trooper"],
			["TSTw Ski - Women", "TSTw"],
			["TST", "TST"],
			["Verdict", "Verdict"],
			["Wall", "Wall"],
			["Watea 84", "Watea 84"],
			["Watea Jr Kids Skis with FJ 4 Bindings", "Watea Jr + FJ4 AC Jr Rail Bindings - Youth - Boy's"],
			["Watea Jr Kids Skis with FJ 7 Bindings", "Watea Jr + FJ7 AC Jr Rail Bindings - Youth - Boy's"],
			["Zealot", "Zealot"]]
			
			#			["Avenger 76 Basalt Skis with TPI2 Axium 120 Bindings", "Avenger 76 Basalt + TPI²\/Axium 120 Bindings"],

      name_array2.each do |name_pair|
        if @name.include?("#{name_pair[0]}")
           @name = "#{name_pair[1]}"
           break
        end
      end

      puts @name

			#model year
			model_year = data.css(".productdetail h1.productname").text.to_i
			@model_year = model_year.slice(/\d{4}/)
			if @model_year.nil?
				@model_year = 2010
			elsif @model_year == 5500
				@model_year = 2013
			end
			

			# #description
			@description = data.css("#pdpTab2 p").text
			
			
			# # #ability level not available

			# #rocker type
			@rocker_type = data.css(":nth-child(14) .value").text.strip
			
			# #ski type
			@ski_type = data.css("#pdpTab3 :nth-child(3) .value").text.strip
			if @ski_type.include? "All-Mountain"
				@ski_type = "All Mountain Skis"
			elsif @name.include? "Binding"
				@ski_type = "All Mountain Ski Packages"
			elsif @ski_type.include? "Frontside"
				@ski_type = "Carving Skis"
			elsif @ski_type.include? "Freestyle"
				@ski_type = "Park & Pipe Skis"
			elsif @ski_type.include? "Powder"
				@ski_type = "Big Mountain Skis"
			elsif @ski_type == "2010"
				@ski_type = "Ski Boards"
			elsif @ski_type == "Yes"
				@ski_type = "Ski Boards"
			end

			# #gender
			gender_text = data.css("#pdpTab3 :nth-child(2) .value").text.strip
			if gender_text.include? "Women"
				@gender = "Women's"
			elsif gender_text.include? "Girl"
				@gender = "Youth"
			elsif gender_text.include? "Kid"
				@gender = "Youth"
			else
				@gender = "Men's"
			end
			

			# #price 
			price = data.css(".productinfo .salesprice")
			price = price.text.strip.gsub(',','')
			@price = price.delete("$")
			

			# #image link
		  match = data.text.match /http:\/\/s7d5.scene7.com\/is\/image\/SummitSports\/(.+)\?\$(\d+)\$/
		  image_link = match[0]
		  @big_image_link = image_link.gsub(/\$\d+\$$/, "$600$")		


		  if @name.include?("Mounting and Adjustment")
				elsif @name.include?("Binding")
          @ski = Ski.create(:name => @name, :ability_level => "na", :description => @description, :gender => @gender, :model_year => @model_year, :rocker_type => @rocker_type, :ski_type => @ski_type, :brand_id => @brand_final.id)

          @sizes.each do |size_available|
            Inventory.create(:price => @price, :product_url => @url2, :ski_id => @ski.id, :size_available => size_available, :store_id => @store.id)
          end

          image = Image.create(:image_url => @big_image_link, :ski_id => @ski.id)

          review = Review.create(:average_review => 0, :number_of_reviews => 0, :ski_id => @ski.id, :store_id => @store.id)
		
	      elsif Ski.where(:name => @name).exists?
	      	if Ski.where(:name => @name).where(:model_year => @model_year).where(:gender => @gender).exists?
	      		@ski4 = Ski.where(:name => @name).where(:model_year => @model_year).where(:gender => @gender).first

	          
		          @sizes.each do |size_available|
		            Inventory.create(:price => @price, :product_url => @url2, :ski_id => @ski4.id, :size_available => size_available, :store_id => @store.id)
		          end
	          	  image = Image.create(:image_url => @big_image_link, :ski_id => @ski4.id)
	          	  review = Review.create(:average_review => 0, :number_of_reviews => 0, :ski_id => @ski4.id, :store_id => @store.id)
	      	  

	      	elsif Ski.where(:name => @name).where(:model_year => @model_year).exists?

	      		@ski1 = Ski.where(:name => @name).where(:model_year => @model_year).first

	          
		          @sizes.each do |size_available|
		            Inventory.create(:price => @price, :product_url => @url2, :ski_id => @ski1.id, :size_available => size_available, :store_id => @store.id)
		          end
		      	image = Image.create(:image_url => @big_image_link, :ski_id => @ski1.id)
		      	review = Review.create(:average_review => 0, :number_of_reviews => 0, :ski_id => @ski1.id, :store_id => @store.id)
		      

	        else
	        	@ski2 = Ski.create(:name => @name, :ability_level => "na", :description => @description, :gender => @gender, :model_year => @model_year, :rocker_type => @rocker_type, :ski_type => @ski_type, :brand_id => @brand_final.id)

	          @sizes.each do |size_available|
	            Inventory.create(:price => @price, :product_url => @url2, :ski_id => @ski2.id, :size_available => size_available, :store_id => @store.id)
	          end
	          image = Image.create(:image_url => @big_image_link, :ski_id => @ski2.id)
	          review = Review.create(:average_review => 0, :number_of_reviews => 0, :ski_id => @ski2.id, :store_id => @store.id)
	        end
	      else
	      	 @ski3 = Ski.create(:name => @name, :ability_level => "na", :description => @description, :gender => @gender, :model_year => @model_year, :rocker_type => @rocker_type, :ski_type => @ski_type, :brand_id => @brand_final.id)

          @sizes.each do |size_available|
            Inventory.create(:price => @price, :product_url => @url2, :ski_id => @ski3.id, :size_available => size_available, :store_id => @store.id)
          end
          image = Image.create(:image_url => @big_image_link, :ski_id => @ski3.id)
          review = Review.create(:average_review => 0, :number_of_reviews => 0, :ski_id => @ski3.id, :store_id => @store.id)
	      end

		 	# average_review
		 	# @average_review = data.css(".pr-rating .pr-rounded .average").text
		 	# if review == "0"
		  #       @average_review = "na"
			 #    else
			 #    @average_review = review
		  #   end
		    
		  #   number of reviews
		  #   @number_of_reviews = data.css("span.count").text.scan(/\d/).join ''
		  #     if @number_of_reviews.empty?
		  #       @number_of_reviews = "na"
		  #     end
		
		end
	end
end