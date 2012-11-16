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

	@links_array.each do |product_link|
		url = product_link
		data = Nokogiri::HTML(open(url))
		brand = Brand.find_or_create_by_company(:company => data.css("h1.fn").css("strong.brand").text)
		puts brand.company
		x = data.at('strong').next.text
		name = x.slice(0...(x.index('Skis')))
		model_year = data.css("h1.fn").text.gsub(/[^\d]/,"").slice(-4..-1).to_i
		description = data.css(".description").text

		ability_level_input = data.at_css('span.values').text
		ability_level = if ability_level_input.include?("/") || ability_level_input.include?("@")
			"na"
		else
			ability_level_input
		end

		rocker_type = data.xpath('//span[contains(text(), "Rocker Type")]').first.next_element.text

		if !data.xpath('//span/a[contains(@href, "/all-mountain.aspx")]').text.empty?
			ski_type = data.xpath('//span/a[contains(@href, "/all-mountain.aspx")]').text
		elsif !data.xpath('//span/a[contains(@href, "/powder.aspx")]').text.empty?
			ski_type = data.xpath('//span/a[contains(@href, "/powder.aspx")]').text
		elsif !data.xpath('//span/a[contains(@href, "/twin-tip.aspx")]').text.empty?
			ski_type = data.xpath('//span/a[contains(@href, "/twin-tip.aspx")]').text
		elsif !data.xpath('//span/a[contains(@href, "/park-pipe.aspx")]').text.empty?
			ski_type = data.xpath('//span/a[contains(@href, "/park-pipe.aspx")]').text
		elsif !data.xpath('//span/a[contains(@href, "/alpine-touring.aspx")]').text.empty?
			ski_type = data.xpath('//span/a[contains(@href, "/alpine-touring.aspx")]').text
		elsif !data.xpath('//span/a[contains(@href, "/carving.aspx")]').text.empty?
			ski_type = data.xpath('//span/a[contains(@href, "/carving.aspx")]').text
		else
			ski_type = "na"	
		end 

		if data.css("h1.fn").text.include? "Women's"
			gender = "Women's"
		else
			gender = "Men's"
		end

		ski = Ski.create(:name => name, :ability_level => ability_level, :description => description, :gender => gender, :model_year => model_year, :rocker_type => rocker_type, :ski_type => ski_type, :brand_id => brand.id)
		puts ski.name
	end

	########### Inventories table - need to finish specs table and stores table ########

	# @prices = []	

	# @links_array.each do |product_link|
	# 	url = product_link
	# 	data = Nokogiri::HTML(open(url))
	# 	@prices << data.css("#price").text.strip
	# end

	# @ski_id_array = []
	# Ski.all.each do |ski|
	# 	@ski_id_array << ski.id
	# end

	# @ski_id_array = []
	# Ski.all.each do |ski|
	# 	@ski_id_array << ski.id
	# end

	# @skis.size.times do |x|
	# 	Inventory.create(:price => @prices[x], :product_url => @links_array[x], :ski_id => @ski_id_array[x], :spec_id => @TBD[x], :store_id => @TBD[x])
	# end

	############# Images table ########

	# @images = []	

	# @links_array.each do |product_link|
	# 	url = product_link
	# 	data = Nokogiri::HTML(open(url))
	# 	image_link = data.css(".mainImageContainer")
	# 	image_link.each do |link| 
	# 		@images << "http://www.evo.com#{link['href']}"
	# 	end
	# end	

	# @ski_id_array = []
	# Ski.all.each do |ski|
	# 	@ski_id_array << ski.id
	# end

	# @images.size.times do |x|
	# 	Image.create(:image_url => @images[x], :ski_id => @ski_id_array[x])
	# end

	################## Reviews Table (need to add review model) ############

	# @number_of_reviews = []

	# @links_array.each do |product_link|
	# 	url = product_link
	# 	data = Nokogiri::HTML(open(url))
	# 	string_object = data.css(".pr-snapshot-average-based-on-text").text.gsub(/[^\d]/,"")
	# 	if !string_object.empty?
	# 	@number_of_reviews  << string_object
	# 	else
	# 		@number_of_reviews << "na"
	# 	end
	# end

	# puts @number_of_reviews

	# @review_average = []

	# @links_array.each do |product_link|
	# 	url = product_link
	# 	data = Nokogiri::HTML(open(url))
	# 	string_object = data.css(".average").text
	# 	if !string_object.empty?
	# 	@review_average  << string_object
	# 	else
	# 		@review_average << "na"
	# 	end
	# end

	# puts @review_average

	# @table_body_array = []
	# @table_header_array = []
	# @test_array = []

	# @links_array.each do |product_link|
	# 	url = product_link
	# 	data = Nokogiri::HTML(open(url))
	# 	data.xpath('//table[@class="matrixSpecTable"]//thead').each do |table_header|
	# 		header_columns = table_header.search('th/text()').map(&:to_s)
	# 		if !header_columns.nil?
	# 			@table_header_array << [{
	# 				:row_label_one => header_columns[0],
	# 				:size_one => header_columns[1],
	# 				:size_two => header_columns[2],
	# 				:size_three => header_columns[3],
	# 				:size_four => header_columns[4],
	# 				:size_five => header_columns[5],
	# 				:size_six => header_columns[6],
	# 				:size_seven => header_columns[7]
	# 			}]
	# 		else
	# 			@table_header_array << [{
	# 				:row_label_one => "na",
	# 				:size_one => "na",
	# 				:size_two => "na",
	# 				:size_three => "na",
	# 				:size_four => "na",
	# 				:size_five => "na",
	# 				:size_six => "na",
	# 				:size_seven => "na"
	# 			}]
	# 		end
	# 	end	

	# 	data.xpath('//table[@class="matrixSpecTable"]//tr').each do |row|
	# 		columns = row.search('td/text()').map(&:to_s)
	# 		if !columns.nil?
	# 			@table_body_array << [{
	# 				:row_label => columns[0],
	# 				:size_one => columns[1],
	# 				:size_two => columns[2],
	# 				:size_three => columns[3],
	# 				:size_four => columns[4],
	# 				:size_five => columns[5]
	# 			}]
	# 		else
	# 			@table_body_array << [{	
	# 				:row_label_ => "na",
	# 				:size_one => "na",
	# 				:size_two => "na",
	# 				:size_three => "na",
	# 				:size_four => "na",
	# 				:size_five => "na"
	# 			}]
	# 		end	
	# 	end
	# end	

	# puts @table_header_array.inspect
	# puts @table_body_array

	####### Sizes Available ########
		
	# @sizes = []
	# @placeholder = []
	# @links_array.each do |product_link|
	#   url = product_link
	#   data = Nokogiri::HTML(open(url))
	#   @sizes_available_array = data.at_css('.buttonContainer').text.strip.scan(/\d*/)
	#   @placeholder << @sizes_available_array.select {|string| string.length == 3}
	#   end
	#   @placeholder.each do |placeholder_object|
	#     @sizes << "#{placeholder_object}"
	#   end  	  	
	# puts @sizes

end



spec = [{
	:length => 177,
	:ski_id => 2,
	:tail_width => 120,
	:tip_width => 125, 
	:turning_radius => 25,
	:waist_width => 100,
	:weight => 2000
}]



specs = []
doc.css('th').each.with_index do |th, i|
	next if i == 0
	specs << { :length => th.text.to_i }
end

spec_labels = {
	'Turning Radius (m)' => :turning_radius
}

doc.css('tr').each do |tr|
	key = :something

	tr.css('td').each.with_index do |td, i|
		if i == 0
			key = spec_labels[td.text]
		else
			specs[i-1][key] = td.text
		end
	end
end
