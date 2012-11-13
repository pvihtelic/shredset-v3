desc "scraper"
task :scrape => :environment do 
	require 'nokogiri'
	require 'open-uri'

	url = "http://www.evo.com/shop/ski/skis.aspx"
		
	data = Nokogiri::HTML(open(url))
	product_links = data.css("div.product.item.hproduct a")
	product_links.each{|link| puts "#{link['href']}"} 
	
end