class AddSizeAvailableToInventory < ActiveRecord::Migration
  def change
  	remove_column :inventories, :spec_id
  	add_column :inventories, :size_available, :integer
  end
end
