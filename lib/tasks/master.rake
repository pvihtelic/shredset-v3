desc "master"
require 'evo.rb'
require 'backcountry.rb'

task :all => :environment do
	Evo.scrape
	Backcountry.scrape
end