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

############ Brands table ########

	@brands = []	

	@links_array.each do |product_link|
		url = product_link
		data = Nokogiri::HTML(open(url))
		@brands << data.css("h1.fn").css("strong.brand").text
	end

	@brands.each do |brand|
		Brand.create(:company => brand)
	end

########### Skis table #########

	@names = []	

	@links_array.each do |product_link|
		url = product_link
		data = Nokogiri::HTML(open(url))
		x = data.at('strong').next.text
		@names << x.slice(0...(x.index('Skis')))
	end

	@model_years = []	

	@links_array.each do |product_link|
		url = product_link
		data = Nokogiri::HTML(open(url))
		@model_years << data.css("h1.fn").text.gsub(/[^\d]/,"").slice(-4..-1).to_i
	end

	@descriptions = []	

	@links_array.each do |product_link|
		url = product_link
		data = Nokogiri::HTML(open(url))
		@descriptions << data.css(".description").text
	end

	@ability_level = []

	@links_array.each do |product_link|
		url = product_link
		data = Nokogiri::HTML(open(url))
		string_object = data.at_css('span.values').text
		if string_object.include? "/"
			@ability_level << "na"
			elsif string_object.include? "@"
				@ability_level << "na"
		else
			@ability_level << string_object
		end		
	end	

	@rocker_type = []

	@links_array.each do |product_link|
		url = product_link
		data = Nokogiri::HTML(open(url))
		@rocker_type << data.xpath('//span[contains(text(), "Rocker Type")]').first.next_element.text
	end	

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

	@gender = []

	@links_array.each do |product_link|
		url = product_link
		data = Nokogiri::HTML(open(url))
		if data.css("h1.fn").text.include? "Women's"
			@gender << "Women's"
		else
			@gender << "Men's"	
		end
	end

	@brand_id_array = []
	Brand.all.each do |brand|
		@brand_id_array << brand.id
	end

	@skis.size.times do |x|
		Ski.create(:name => @names[x], :ability_level => @ability_level[x], :description => @descriptions[x], :gender => @gender[x], :model_year => @model_years[x], :rocker_type => @rocker_type[x], :ski_type => @ski_type[x], :brand_id => @brand_id_array[x])
	end

########### Inventories table - need to finish specs table and stores table ########

	@prices = []	

	@links_array.each do |product_link|
		url = product_link
		data = Nokogiri::HTML(open(url))
		@prices << data.css("#price").text.strip
	end

	@ski_id_array = []
	Ski.all.each do |ski|
		@ski_id_array << ski.id
	end

	@ski_id_array = []
	Ski.all.each do |ski|
		@ski_id_array << ski.id
	end

	@skis.size.times do |x|
		Inventory.create(:price => @prices[x], :product_url => @links_array[x], :ski_id => @ski_id_array[x], :spec_id => @TBD[x], :store_id => @TBD[x])
	end

############# Images table ########

	@images = []	

	@links_array.each do |product_link|
		url = product_link
		data = Nokogiri::HTML(open(url))
		image_link = data.css(".mainImageContainer")
		image_link.each do |link| 
			@images << "http://www.evo.com#{link['href']}"
		end
	end	

	@ski_id_array = []
	Ski.all.each do |ski|
		@ski_id_array << ski.id
	end

	@images.size.times do |x|
		Image.create(:image_url => @images[x], :ski_id => @ski_id_array[x])
	end

################## Number of Reviews (need to add review model) ############

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

################# Average Review #################

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

end