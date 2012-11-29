class AddColumnToPriceRange < ActiveRecord::Migration
  def change
  	add_column :price_ranges, :low, :integer
  	add_column :price_ranges, :high, :integer
  end
end
