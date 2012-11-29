class Inventory < ActiveRecord::Base
  attr_accessible :price, :product_url, :ski_id, :size_available, :store_id

  belongs_to :ski
  belongs_to :spec
  belongs_to :store

  def self.search_price(prices)
  	if prices.count > 1
  		prices.delete_at(0)
  	end
  	
  	@skis_array = []

  	prices.each do |price|
  		price_range = PriceRange.where(:price_range => price)
  		price_range = price_range.first
  		inventories = self.where(:price => price_range.low..price_range.high)
  		inventories.each do |inventory|
  			ski_in_price_range = inventory.ski
  			@skis_array << ski_in_price_range
  		end
  	end
  	return @skis_array
  end






  	# @skis_array = []
  	# if prices.include? '<200' 
  	# 	price_range = PriceRange.where(:price_range => '<200' ) 
  	# 	price_range = price_range.first
   #    inventories = self.where(:price => price_range.low..price_range.high)
   #    inventories.each do |inventory|
   #      ski_in_price_range = inventory.ski
   #      @skis_array << ski_in_price_range
   #    end
   #  end

   #  if prices.include? '200-400'
   #  	price_range = PriceRange.where(:price_range => '200-400' ) 
  	# 	price_range = price_range.first
   #    inventories = self.where(:price => price_range.low..price_range.high)
   #    inventories.each do |inventory|
   #      ski_in_price_range = inventory.ski
   #      @skis_array << ski_in_price_range
   #    end
   #  end

   #  if prices.include? '400-600'
   #  	price_range = PriceRange.where(:price_range => '400-600' ) 
  	# 	price_range = price_range.first
   #    inventories = self.where(:price => price_range.low..price_range.high)
   #    inventories.each do |inventory|
   #      ski_in_price_range = inventory.ski
   #      @skis_array << ski_in_price_range
   #    end
   #  end

   #  if prices.include? '600-800'
   #  	price_range = PriceRange.where(:price_range => '600-800' ) 
  	# 	price_range = price_range.first
   #    inventories = self.where(:price => price_range.low..price_range.high)
   #    inventories.each do |inventory|
   #      ski_in_price_range = inventory.ski
   #      @skis_array << ski_in_price_range
   #    end
   #  end

   #  if prices.include? '800-1000'
   #  	price_range = PriceRange.where(:price_range => '800-1000' ) 
  	# 	price_range = price_range.first
   #    inventories = self.where(:price => price_range.low..price_range.high)
   #    inventories.each do |inventory|
   #      ski_in_price_range = inventory.ski
   #      @skis_array << ski_in_price_range
   #    end
   #  end

   #  if prices.include? '1000+'
   #  	price_range = PriceRange.where(:price_range => '1000+' ) 
  	# 	price_range = price_range.first
   #    inventories = self.where(:price => price_range.low..price_range.high)
   #    inventories.each do |inventory|
   #      ski_in_price_range = inventory.ski
   #      @skis_array << ski_in_price_range
   #    end
   #  end

   #  return @skis_array
   # end
end
