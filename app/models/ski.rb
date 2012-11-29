class Ski < ActiveRecord::Base
  attr_accessible :ability_level, :brand_id, :description, :gender, :model_year, :name, :rocker_type, :ski_type

  has_many :specs
  has_many :inventories
  has_many :stores, :through => :inventories
  has_many :images
  has_many :reviews
  belongs_to :brand

end
