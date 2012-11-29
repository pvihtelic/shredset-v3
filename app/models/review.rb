class Review < ActiveRecord::Base
  attr_accessible :average_review, :number_of_reviews, :ski_id, :store_id

  belongs_to :ski

end
