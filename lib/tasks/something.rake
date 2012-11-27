desc "scraper"

task :something => :environment do 
	require 'nokogiri'
	require 'open-uri'

	@url = ["http://www.evo.com/a-shop/ski/skis/p_7.aspx"]

	@links_array = []

	@url.each do |url|
		data = Nokogiri::HTML(open(url))
			product_links = data.css("div.product.item.hproduct a")
			product_links.each do |link|
				@link_strings = "#{link['href']}"
				if @link_strings.blank?
				else
					@links_array << "http://www.evo.com#{@link_strings}"
				end
			end
		end


	@links_array.each do |product_link|
		data = Nokogiri::HTML(open(product_link))
		if !data.css("#detailsPage div.OutOfStock h2").present?
			x = data.at('strong').next.text
			name = x.slice(0...(x.index('Skis')))
			model_year = data.css("h1.fn").text.gsub(/[^\d]/,"").slice(-4..-1).to_i
			if data.css("h1.fn").text.include? "Women's"
					gender = "Women's"
				elsif data.css("h1.fn").text.include? "Youth"
					gender = "Youth"
				else
					gender = "Men's"
			end
			ability_level_input = data.at_css('span.values').text
				ability_level = if ability_level_input.include?("/") || ability_level_input.include?("@")
					"na"
				else
					ability_level_input
				end
			description = data.css(".description").text
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
			price = data.css("#price").text.strip.gsub('$','')
			average_review_object = data.css(".average").text
				if !average_review_object.empty?
				average_review = average_review_object
				else
				average_review = "na"
				end
			puts name
			puts model_year
			puts gender
			puts description
			puts ability_level
			puts rocker_type
			puts ski_type
			puts price
			puts average_review
		end
	end

end