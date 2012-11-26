desc "scrape2"

task :scrape2 => :environment do 
	require 'nokogiri'
	require 'open-uri'

	@url = "http://www.backcountry.com/skis"

	data = Nokogiri::HTML(open(@url))
	product_links = data.css("div.product.item-listing a")
	@links_array = []
	product_links.each do |link|
		@link_strings = "#{link['href']}"
		if @link_strings.blank?
		else
			@links_array << "http://www.backcountry.com#{@link_strings}"
		end
	end

@store = Store.create(:store_url => "http://www.backcountry.com/", :vendor => "backcountry.com")

@links_array.each do |product_link|
	@url = product_link
	data = Nokogiri::HTML(open(@url))
	
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
		@ski_type = 'Powder'
	elsif ski_type.include? "Carve"
		@ski_type = 'Carving'
	elsif ski_type.include? "All Mountain"
		@ski_type = 'All Mountain'
	elsif ski_type.include? "Fat"
		@ski_type = "Powder"
	elsif ski_type.include? "Alpine Park"
		@ski_type = 'Park-Pipe'
	else @ski_type = 'na'
	end

	#gender not available

	#price
	@price = data.css(".buy-box .product-price").text.strip.gsub('$', '')
	
	#image link
	image_href = data.css("#product_image .wraptocenter a")
	image_href.each do |link|
		link2 = link['href'].dup
		link2[0..1] = ''
		@image_link = link2
	end

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
		number_of_reviews = "na"
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

	sizes_available = data.css(".ui-dialog")
	puts sizes_available.inspect

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
