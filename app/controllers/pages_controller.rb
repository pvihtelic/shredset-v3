class PagesController < ApplicationController

	def home
		@skis = Ski.all

    	respond_to do |format|
     	format.html # index.html.erb
      	format.json { render json: @skis }

      	@brands = Brand.all 
      	
      	@ski_types = Ski.find(:all, :select => "DISTINCT ski_type")
        @genders = Ski.find(:all, :select => "DISTINCT gender")
        @ability_levels = Ski.find(:all, :select => "DISTINCT ability_level")
        @image = Image.find(:all, :order => "id desc", :limit => 1)
    	end
	end

end
