desc "master"
require 'skis.rb'
# require 'evo.rb' 
# require 'backcountry.rb'

task :all => :environment do
  # Evo.scrape
  # Backcountry.scrape
  Skis.scrape
end