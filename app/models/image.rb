class Image < ActiveRecord::Base
  attr_accessible :image_url, :ski_id

  belongs_to :ski
end
