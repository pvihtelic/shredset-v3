class AddPriceColumnToSkis < ActiveRecord::Migration
  def change
  	add_column :skis, :price, :decimal
  end
end
