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
        @price_ranges = PriceRange.all

        top_reviews = Review.order("average_review desc")
        
        #ALL MOUNTAIN
        @all_mountain_top_skis = []
        @twin_tip_top_skis = []
        @powder_top_skis = []  
        @park_and_pipe_top_skis = []
        @alpine_touring_top_skis = []
        @all_mountain_ski_packages_top_skis = []

        top_reviews.each do |review|  
          all_mountain_top_ski = Ski.where(:ski_type => "All Mountain Skis", :id => review.ski_id)
          all_mountain_top_ski.each do |ski_object|
            @ski_object = ski_object
            @all_mountain_top_skis << @ski_object
          end
          twin_tip_top_ski = Ski.where(:ski_type => "Twin Tip Skis", :id => review.ski_id)
          twin_tip_top_ski.each do |ski_object|
            @ski_object = ski_object
            @twin_tip_top_skis << @ski_object
          end  
          powder_top_ski = Ski.where(:ski_type => "Powder Skis", :id => review.ski_id)
          powder_top_ski.each do |ski_object|
            @ski_object = ski_object
            @powder_top_skis << @ski_object
          end
          # park_and_pipe_top_ski = Ski.where(:ski_type => "Park & Pipe Skis", :id => review.ski_id)
          # park_and_pipe_top_ski.each do |ski_object|
          #   @ski_object = ski_object
          #   if nil?
          #   else
          #   @park_and_pipe_top_skis << @ski_object
          #   end
          # end
          # alpine_touring_top_ski = Ski.where(:ski_type => "Park & Pipe Skis", :id => review.ski_id)
          # alpine_touring_top_ski.each do |ski_object|
          #   @ski_object = ski_object
          #   if nil?
          #   else
          #   @alpine_touring_top_skis << @ski_object
          #   end
          # end
          # all_mountain_ski_packages_top_ski = Ski.where(:ski_type => "Park & Pipe Skis", :id => review.ski_id)
          # all_mountain_ski_packages_top_ski.each do |ski_object|
          #   @ski_object = ski_object
          #   if nil?
          #   else
          #   @all_mountain_ski_packages_top_skis << @ski_object
          #   end
          # end
        end
    	end
	end

end
