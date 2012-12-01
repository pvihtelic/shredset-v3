require 'rubygems'
require 'watir'
require 'nokogiri'

#start the browser up
Watir::Browser.default = "chrome"
browser = Watir::Browser.start  "http://www.weather.com/"

browser.text_field(:id, "whatwhereForm2").set("san diego, ca")

browser.button(:src,"http://i.imwx.com/web/common/searchbutton.gif").click

browser.link(:text, "10-Day").click

#pass in current page's html to nokogiri for parsing
page_html = Nokogiri::HTML.parse(browser.html)

puts page_html.xpath(".//*[@id='tenDay']/div[8]/div/div[2]/div/p").inner_text