class Skis

	def self.scrape
		require 'nokogiri'
		require 'open-uri'

		@url = "http://www.skis.com/skis/100,default,sc.html?start=0&sz=24"

		data = Nokogiri::HTML(open(@url))
		product_links = data.css(".productlisting .product .name a")
		@links_array = []
		product_links.each do |link|
			@link_string = "#{link['href']}"
			@links_array << @link_string
		end


		@store = Store.create(:store_url => "http://www.skis.com/", :vendor => "skis.com")

		@links_array.each do |product_link|
			@url2 = product_link
			data = Nokogiri::HTML(open(@url2))


			# #brand
			# brand_text = data.css(".productdetail h1.productname").text
			# if brand_text.include? "4 FRNT"
			# 	@brand = brand_text.slice(/(4 FRNT)/)
			# elsif brand_text.include? "5th Element"
			# 	@brand = brand_text.slice(/(5th Element)/)
			# elsif brand_text.include? "Black Diamond"
			# 	@brand = brand_text.slice(/(Black Diamond)/)
			# elsif brand_text.include? "Crazy Creek"
			# 	@brand = brand_text.slice(/(Crazy Creek)/)
			# elsif brand_text.include? "Epic Planks"
			# 	@brand = brand_text.slice(/(Epic Planks)/)
			# elsif brand_text.include? "Hyper Flex"
			# 	@brand = brand_text.slice(/(Hyper Flex)/)
			# elsif brand_text.include? "Lucky Bums"
			# 	@brand = brand_text.slice(/(Lucky Bums)/)
			# elsif brand_text.include? "P Tech"
			# 	@brand = brand_text.slice(/(P Tech)/)
			# elsif brand_text.include? "SA Snowblades"
			# 	@brand = brand_text.slice(/(SA Snowblades)/)
			# elsif brand_text.include? "Snow Carve"
			# 	@brand = brand_text.slice(/(Snow Carve)/)
			# elsif brand_text.include? "South Line"
			# 	@brand = brand_text.slice(/(South Line)/)
			# else
			# 	brand_array = brand_text.split ' '
			# 	@brand = brand_array[0]
			# end
			
			# brand_final = Brand.find_or_create_by_company(:company => @brand)
   #    puts brand_final.company

			# #name
			# name = data.css(".productdetail h1.productname").text
			# if name.include? "4 FRNT"
			# 	@name = name.delete("4 FRNT")
			# 	@name = @name.delete(-1..-4)
			# elsif name.include? "5th Element"
			# 	@name = name.delete("5th Element")
			# 	@name = @name.delete(-1..-4)
			# elsif name.include? "Black Diamond"
			# 	@name = name.delete("Black Diamond")
			# 	@name = @name.delete(-1..-4)
			# elsif name.include? "Crazy Creek"
			# 	@name = name.delete("Crazy Creek")
			# 	@name = @name.delete(-1..-4)
			# elsif name.include? "Epic Planks"
			# 	@name = name.delete("Epic Planks")
			# 	@name = @name.delete(-1..-4)
			# elsif name.include? "Hyper Flex"
			# 	@name = name.delete("Hyper Flex")
			# 	@name = @name.delete(-1..-4)
			# elsif name.include? "Lucky Bums"
			# 	@name = name.delete("Lucky Bums")
			# 	@name = @name.delete(-1..-4)
			# elsif name.include? "P Tech"
			# 	@name = name.delete("P Tech")
			# 	@name = @name.delete(-1..-4)
			# elsif name.include? "SA Snowblades"
			# 	@name = name.delete("SA Snowblades")
			# 	@name = @name.delete(-1..-4)
			# elsif name.include? "Snow Carve"
			# 	@name = name.delete("Snow Carve")
			# 	@name = @name.delete(-1..-4)
			# elsif name.include? "South Line"
			# 	@name = name.delete("South Line")
			# 	@name = @name.delete(-1..-4)
			# else
			# 	name_array = name.split ' '
			# 	name_array.delete_at(0)
			# 	name_array.delete_at(-1)
			# 	@name = name_array.join ' '
			# end
   #    # puts @name

			# #model year
			# model_year = data.css(".productdetail h1.productname").text
			# @model_year = model_year.slice(/\d{4}/)
		

			# #description
			# @description = data.css("#pdpTab2 p").text
			
			# #ability level no available

			# #rocker type
			# @rocker_type = data.css(":nth-child(14) .value").text.strip
			
			# #ski type
			# # @ski_type = data.css("#pdpTab3 :nth-child(3) .value").text.strip
			# # @ski_type = @ski_type.slice(/[a-zA-z]*/)
			# # puts @ski_type.inspect


			# #gender
			# gender_text = data.css("#pdpTab3 :nth-child(2) .value").text.strip
			# if gender_text.include? "Women"
			# 	@gender = "Women's"
			# elsif gender_text.include? "Girl"
			# 	@gender = "Youth"
			# elsif gender_text.include? "Kid"
			# 	@gender = "Youth"
			# else
			# 	@gender = "Men's"
			# end

			# #price 
			# price = data.css(".productinfo .salesprice")
			# price = price.text.strip.inspect
			# @price = price.delete("$")

			#image link - not working
		  match = data.text.match /http:\/\/s7d5.scene7.com\/is\/image\/SummitSports\/(.+)\?\$(\d+)\$/
		  image_link = match[0]
		  big_image_link = image_link.gsub(/\$\d+\$$/, "$600$")
		  puts big_image_link
		  puts "-"*15

	  	#average review
	  	# review = data.css(".pr-snippet-stars .pr-snippet-rating-decimal")
	  	# puts review.inspect

	  	#number of reviews
	  	# number_of_reviews = data.css(".pr-snippet-read-write a.pr-snippet-link span")
      # puts number_of_reviews.inspect


		# @links_array = []
		# product_links.each do |link|
		# 	@link_strings = "#{link['href']}"
		# 	if @link_strings.blank?
		# 	else
		# 		@links_array << @link_strings
		# 	end
		# end

		# puts @link_array


		
		end
	end
end