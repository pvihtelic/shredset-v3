desc "scraper"

task :something => :environment do 
	require 'nokogiri'
	require 'open-uri'

	#@url = ["http://www.evo.com/shop/ski/skis.aspx", "http://www.evo.com/shop/ski/skis/p_2.aspx", "http://www.evo.com/shop/ski/skis/p_3.aspx", "http://www.evo.com/shop/ski/skis/p_4.aspx", "http://www.evo.com/shop/ski/skis/p_5.aspx", "http://www.evo.com/shop/ski/skis/p_6.aspx", "http://www.evo.com/shop/ski/skis/p_7.aspx", "http://www.evo.com/shop/ski/skis/p_8.aspx", "http://www.evo.com/shop/ski/skis/p_9.aspx", "http://www.evo.com/shop/ski/skis/p_10.aspx", "http://www.evo.com/shop/ski/skis/p_11.aspx"]
	
	@index_link = ["google.com"]

	@links_array = []

	@index_link.each do |index_link|
		data = Nokogiri::HTML(open(index_link))
		product_links = data.css("div.product.item.hproduct a")
		product_links.each do |link|
			@link_strings = "#{link['href']}"
			if @link_strings.blank?
			else
				@links_array << "http://www.evo.com#{@link_strings}"
			end
		end
	end

	puts @links_array
end