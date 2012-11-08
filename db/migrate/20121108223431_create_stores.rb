class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :vendor
      t.string :store_url

      t.timestamps
    end
  end
end
