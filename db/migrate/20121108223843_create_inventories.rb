class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.integer :ski_id
      t.integer :spec_id
      t.integer :store_id
      t.string :product_url
      t.decimal :price

      t.timestamps
    end
  end
end
