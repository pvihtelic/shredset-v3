class Ski < ActiveRecord::Base
  attr_accessible :ability_level, :brand_id, :description, :gender, :model_year, :name, :rocker_type, :ski_type

  has_many :specs
  has_many :inventories
  has_many :stores, :through => :inventories, :uniq => true
  has_many :images
  has_many :reviews
  belongs_to :brand


  def self.search_characteristics(ski_type, gender, ability_level, company, name)
  	@skis = Ski.scoped
  	if ski_type.any?
        @skis = @skis.where(:ski_type => ski_type)
    end
    if gender.any?
      @skis = @skis.where(:gender => gender)
    end
    if ability_level.any?
      @skis = @skis.where(:ability_level => ability_level)
    end
    if company.any?
      brand_object = Brand.where(:company => company)
     
      # @id_array = []
      # brand_object.each do |brand|
      #   @id_array << brand.id
      # end 

      @id_array = brand_object.map(&:id)


      @skis = @skis.where(:brand_id => @id_array)
    end
    if name.any?
      @skis = @skis.where(:name => name)
    end
    return @skis
   end

end
