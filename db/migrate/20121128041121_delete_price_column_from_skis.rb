class DeletePriceColumnFromSkis < ActiveRecord::Migration
  def change
  	remove_column :skis, :price
  end
end
