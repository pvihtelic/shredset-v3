class Ski < ActiveRecord::Base
  attr_accessible :ability_level, :brand_id, :description, :gender, :model_year, :name, :rocker_type, :ski_type

  has_many :specs
  has_many :inventories
  has_many :stores, :through => :inventories, :uniq => true
  has_many :images
  has_many :reviews
  belongs_to :brand

  paginates_per 30


  def self.search_characteristics(ski_type, gender, company, name, model_year)
  	@skis = Ski.scoped
  	if ski_type.any?
        @skis = @skis.where(:ski_type => ski_type)
    end
    if gender.any?
      @skis = @skis.where(:gender => gender)
    end
    if company.any?
      brand_object = Brand.where(:company => company)

      @id_array = brand_object.map(&:id)

      @skis = @skis.where(:brand_id => @id_array)
    end
    if name.any?
      @skis = @skis.where(:name => name)
    end
    if model_year.any?
      @skis = @skis.where(:model_year => model_year)
    end
    return @skis
   end

end
