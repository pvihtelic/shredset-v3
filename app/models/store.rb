class Store < ActiveRecord::Base
  attr_accessible :store_url, :vendor

  has_many :inventories
  has_many :skis, :through => :inventories
  has_many :brands, :through => :skis
end
