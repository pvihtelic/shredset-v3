desc "scraper"
task :scrape => :environment do 
	require 'nokogiri'
	require 'open-uri'

	url = "http://www.evo.com/shop/ski/skis.aspx"
		
	data = Nokogiri::HTML(open(url))
	product_links = data.css("div.product.item.hproduct a")
	@links_array = []
	product_links.each do |link|
		@link_strings = "#{link['href']}"
		if @link_strings.blank?
		else
			@links_array << "http://www.evo.com#{@link_strings}"
		end
	end

	# @prices = []	

	# @links_array.each do |product_link|
	# 	url = product_link
	# 	data = Nokogiri::HTML(open(url))
	# 	@prices << data.css("#price").text.strip
	# end

	# puts @prices

	# @brands = []	

	# @links_array.each do |product_link|
	# 	url = product_link
	# 	data = Nokogiri::HTML(open(url))
	# 	@brands << data.css("h1.fn").css("strong.brand").text
	# end

	# puts @brands


	# @model_years = []	

	# @links_array.each do |product_link|
	# 	url = product_link
	# 	data = Nokogiri::HTML(open(url))
	# 	@model_years << data.css("h1.fn").text.gsub(/[^\d]/,"").slice(-4..-1).to_i
	# end

	# puts @model_years

	# @descriptions = []	

	# @links_array.each do |product_link|
	# 	url = product_link
	# 	data = Nokogiri::HTML(open(url))
	# 	@descriptions << data.css(".description").text
	# end

	# puts @descriptions

	# @images = []	

	# @links_array.each do |product_link|
	# 	url = product_link
	# 	data = Nokogiri::HTML(open(url))
	# 	image_link = data.css(".mainImageContainer")
	# 	image_link.each do |link| 
	# 		@images << "http://www.evo.com#{link['href']}"
	# 	end
	# end	
	# puts @images

	# @sizes = []
	# @placeholder = []

	# @links_array.each do |product_link|
	# 	url = product_link
	# 	data = Nokogiri::HTML(open(url))
	# 	@sizes_available_array = data.at_css('.buttonContainer').text.strip.scan(/\d*/)
	# 	@placeholder << @sizes_available_array.select {|string| string.length == 3}
	# 	end
	# 	@placeholder.each do |placeholder_object|
	# 		@sizes << "#{placeholder_object}"
	# 	end	

	# puts @sizes

	# @ability_level = []

	# @links_array.each do |product_link|
	# 	url = product_link
	# 	data = Nokogiri::HTML(open(url))
	# 	string_object = data.at_css('span.values').text
	# 	if string_object.include? "/"
	# 		@ability_level << "na"
	# 		elsif string_object.include? "@"
	# 			@ability_level << "na"
	# 	else
	# 		@ability_level << string_object
	# 	end		
	# end	

	# puts @ability_level

	# @rocker_type = []

	# @links_array.each do |product_link|
	# 	url = product_link
	# 	data = Nokogiri::HTML(open(url))
	# 	@rocker_type << data.xpath('//span[contains(text(), "Rocker Type")]').first.next_element.text
	# end	

	# puts @rocker_type

	@ski_type = []

	@links_array.each do |product_link|
		url = product_link
		data = Nokogiri::HTML(open(url))
		if !data.xpath('//span/a[contains(@href, "/all-mountain.aspx")]').text.empty?
		@ski_type << data.xpath('//span/a[contains(@href, "/all-mountain.aspx")]').text
		elsif !data.xpath('//span/a[contains(@href, "/powder.aspx")]').text.empty?
			@ski_type << data.xpath('//span/a[contains(@href, "/powder.aspx")]').text
		elsif !data.xpath('//span/a[contains(@href, "/twin-tip.aspx")]').text.empty?
			@ski_type << data.xpath('//span/a[contains(@href, "/twin-tip.aspx")]').text
		elsif !data.xpath('//span/a[contains(@href, "/park-pipe.aspx")]').text.empty?
			@ski_type << data.xpath('//span/a[contains(@href, "/park-pipe.aspx")]').text
		elsif !data.xpath('//span/a[contains(@href, "/alpine-touring.aspx")]').text.empty?
			@ski_type << data.xpath('//span/a[contains(@href, "/alpine-touring.aspx")]').text
		elsif !data.xpath('//span/a[contains(@href, "/carving.aspx")]').text.empty?
			@ski_type << data.xpath('//span/a[contains(@href, "/carving.aspx")]').text
		else
			@ski_type << "na"	
		end 
	end
	puts @ski_type

end