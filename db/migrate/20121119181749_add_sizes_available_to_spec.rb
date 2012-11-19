class AddSizesAvailableToSpec < ActiveRecord::Migration
  def change
  	add_column :specs, :size_available, :boolean, :default => false
  end
end
