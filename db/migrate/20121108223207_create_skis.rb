class CreateSkis < ActiveRecord::Migration
  def change
    create_table :skis do |t|
      t.string :name
      t.string :ability_level
      t.text :description
      t.string :gender
      t.integer :model_year
      t.string :rocker_type
      t.string :ski_type
      t.integer :brand_id

      t.timestamps
    end
  end
end
