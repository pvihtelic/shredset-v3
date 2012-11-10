class Brand < ActiveRecord::Base
  attr_accessible :company

  has_many :skis
end
