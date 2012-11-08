class CreateSpecs < ActiveRecord::Migration
  def change
    create_table :specs do |t|
      t.integer :length
      t.decimal :turning_radius
      t.integer :tip_width
      t.integer :waist_width
      t.integer :tail_width
      t.integer :weight
      t.integer :ski_id

      t.timestamps
    end
  end
end
