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
		
		price = data.css("#price").text.strip

		image_link_relative = data.css(".mainImageContainer").map{|link| link['href']}
		image_link = "http://www.evo.com#{image_link_relative.join}"

		average_review_object = data.css(".average").text
		if !average_review_object.empty?
		average_review = average_review_object
		else
		average_review = "na"
		end

		review_object = data.css(".pr-snapshot-average-based-on-text").text.gsub(/[^\d]/,"")
		if !review_object.empty?
		number_of_reviews = review_object
		else
			number_of_reviews = "na"
		end

		ski = Ski.create(:name => name, :ability_level => ability_level, :description => description, :gender => gender, :model_year => model_year, :rocker_type => rocker_type, :ski_type => ski_type, :brand_id => brand.id)
		puts ski.name

		store = Store.create(:store_url => "http://www.evo.com/", :vendor => "evo.com")

		# spec = Spec.create(:length => 177, :ski_id => ski.id, :tail_width => 120, :tip_width => 125, :turning_radius => 25, :waist_width => 100, :weight => 2000)

		# inventory = Inventory.create(:price => price, :product_url => url, :ski_id => ski.id, :spec_id => spec.id, :store_id => store.id)

		image = Image.create(:image_url => image_link, :ski_id => ski.id)
		puts image.image_url

		review = Review.create(:average_review => average_review, :number_of_reviews => number_of_reviews, :ski_id => ski.id, :store_id => store.id)
		puts review.average_review
		
	end
end	
	

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


# specs = []
# data.xpath('//table[@class="matrixSpecTable"]//thead/tr').search('th').map(&:to_s).each.with_index do |th, i|
# 	next if i == 0
# 	specs << { :length => th.text.to_i }
# end

# spec_labels = {
# 	'Turning Radius' => :turning_radius,
# 	'Tip' => :tip_width,
# 	'Waist' => :waist_width,
# 	'Tail' => :tail_width, 
# 	'Indv.' => :weight 
# }

# table_row_path = data.xpath('//table[@class="matrixSpecTable"]//tr').each do |tr|
# 	key = :something

# 	tr.table_row_path.search('td').each.with_index do |td, i|
# 		if i == 0
# 			key = spec_labels[td.text]
# 		else
# 			specs[i-1][key] = td.text
# 		end
# 	end
# end


# puts specs

# end