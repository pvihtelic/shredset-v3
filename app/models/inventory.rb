class Inventory < ActiveRecord::Base
  attr_accessible :price, :product_url, :ski_id, :size_available, :store_id

  belongs_to :ski
  belongs_to :spec
  belongs_to :store
end
