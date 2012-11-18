class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.decimal :average_review
      t.integer :number_of_reviews
      t.integer :ski_id
      t.integer :store_id

      t.timestamps
    end
  end
end
