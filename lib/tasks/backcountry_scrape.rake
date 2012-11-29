desc "scrape2"

task :scrape2 => :environment do 
	require 'nokogiri'
	require 'open-uri'

	@url = ["http://www.backcountry.com/skis", "http://www.backcountry.com/Store/catalog/categoryLanding.jsp?categoryId=bcsCat5110005&page=1", "http://www.backcountry.com/Store/catalog/categoryLanding.jsp?categoryId=bcsCat5110005&page=2", "http://www.backcountry.com/Store/catalog/categoryLanding.jsp?categoryId=bcsCat5110005&page=3", "http://www.backcountry.com/Store/catalog/categoryLanding.jsp?categoryId=bcsCat5110005&page=4", "http://www.backcountry.com/Store/catalog/categoryLanding.jsp?categoryId=bcsCat5110005&page=5", "http://www.backcountry.com/Store/catalog/categoryLanding.jsp?categoryId=bcsCat5110005&page=6"]

	@links_array = []

	@url.each do |url|
		data = Nokogiri::HTML(open(url))
		product_links = data.css("div.product.item-listing a")
		product_links.each do |link|
			@link_strings = "#{link['href']}"
			if @link_strings.blank?
			else
				@links_array << "http://www.backcountry.com#{@link_strings}"
			end
		end
	end

	# puts @links_array

	@store = Store.create(:store_url => "http://www.backcountry.com/", :vendor => "backcountry.com")

	@links_array.each do |product_link|
		data = Nokogiri::HTML(open(product_link))
		
		#brand
		brand = Brand.find_or_create_by_company(:company => data.css("h1.header-2.product-name").css("span").text)
		puts brand.company

		#name
		name = data.css(".product-group-title .product-name").text
		name_array = name.split(' ')
		name_array.delete_at(0)
		@name = name_array.join " "

		#model year not available

		#description
		description = data.css(".product-information p").text

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
		if ski_type.include? "Big Mountain"
			@ski_type = "Powder Skis"
		elsif ski_type.include? "Carve"
			@ski_type = "Carving Skis"
		elsif ski_type.include? "All Mountain"
			@ski_type = "All Mountain Skis"
		elsif ski_type.include? "Fat"
			@ski_type = "Powder Skis"
		elsif ski_type.include? "Alpine Park"
			@ski_type = "Park & Pipe Skis"
		else @ski_type = "na"
		end

		#gender not available


		#price
		@price = data.css(".buy-box .product-price").text.strip.gsub('$', '')
		
		#image link
		image_href = data.css("#product_image .wraptocenter a")
		image_href.each do |link|
			link2 = link['href'].dup
			link2[0..1] = ''
			@image_link = "http://#{link2}"
		end

		image_link = @image_link

		puts @image_link.class

		#average review
		review = data.css(".product-group-title .rating .rating-value").text
		if review == "0"
			@average_review = "na"
		else
			@average_review = review
		end

		#number of reviews
		number_of_reviews = data.css(".product-group-title .rating-count a").text.scan(/\d/).join ''
		if number_of_reviews.empty?
			@number_of_reviews = "na"
		end

		#turning radius
		table = data.css(".tech-specs")
		table.search('tr').each do |table|
			headers = table.search('td').text
			if headers.include? "Turn Radius" 
				headers2 = headers.dup
				headers2[0..11] = ''
				@turning_radius = headers2
			end
		end

			# puts @turning_radius

		#lengths
		table = data.css(".tech-specs")
		table.search('tr').each do |table|
			headers = table.search('td').text
			if headers.include? "Length" 
				headers2 = headers.dup
				headers2[0..6] = ''
				@length= headers2
			end
		end

		#dimensions
		table = data.css(".tech-specs")
		table.search('tr').each do |table|
			headers = table.search('td').text
			if headers.include? "Dimensions" 
				headers2 = headers.dup
				headers2[0..10] = ''
				@dimensions = headers2
			end
		end

		#sizes_available
		@sizes = []
		@sizes_available_array = data.xpath('//option[contains(@data-img-title, "One Color")]').text.gsub(/\(.*?\)/, "").scan(/\d{3}/)
		@sizes_available_array.each do |sizes_available|
			@sizes << sizes_available
		end

		@ski = Ski.create(:name => @name, :ability_level => "na", :description => description, :gender => "Men's", :model_year => "na", :rocker_type => @rocker_type, :ski_type => @ski_type, :brand_id => brand.id)

		@product_link = product_link

		@sizes.each do |size_available|
			Inventory.create(:price => @price, :product_url => @product_link, :ski_id => @ski.id, :size_available => size_available, :store_id => @store.id)
		end

		image = Image.create(:image_url => image_link, :ski_id => @ski.id)
		# puts image.image_url

		review = Review.create(:average_review => @average_review, :number_of_reviews => @number_of_reviews, :ski_id => @ski.id, :store_id => @store.id)
		puts review.average_review



		# puts @dimensions.inspect

		# specs = []
		# @length.scan(/\d{3}/).each do |length|
		# 	if @turning_radius.scan(/\d{3}/).include? length
		# 		:turning_radius => 
		# 	end
		# end

		# puts specs
end
end
