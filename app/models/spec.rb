class Spec < ActiveRecord::Base
  attr_accessible :length, :ski_id, :tail_width, :tip_width, :turning_radius, :waist_width, :weight

  belongs_to :ski
  has_many :inventories
end
