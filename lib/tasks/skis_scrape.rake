desc "scrape3"

task :scrape3 => :environment do 
	require 'nokogiri'
	require 'open-uri'

	@url = "http://www.skis.com/skis/100,default,sc.html"

	data = Nokogiri::HTML(open(@url))
	product_links = data.css(".productlisting .product .name a")
	@links_array = []
	product_links.each do |link|
		@link_string = "#{link['href']}"
		@links_array << @link_string
	end


	@store = Store.create(:store_url => "http://www.skis.com/", :vendor => "skis.com")

	@links_array.each do |product_link|
		@url = product_link
		data = Nokogiri::HTML(open(@url))

		#brand
		brand 
	
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