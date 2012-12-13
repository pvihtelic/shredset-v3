class PagesController < ApplicationController

	def home
		@skis = Ski.all

    	respond_to do |format|
     	format.html # index.html.erb
      	format.json { render json: @skis }

      	@companies = Brand.find(:all, :select => "DISTINCT company")
        @ski_types = Ski.find(:all, :select => "DISTINCT ski_type")
        @genders = Ski.find(:all, :select => "DISTINCT gender")
        @names = Ski.find(:all, :select => "DISTINCT name")
        @price_ranges = PriceRange.all
        @model_years = Ski.find(:all, :select => "DISTINCT model_year")

        top_reviews = Review.order("average_review desc")
        
        #ALL MOUNTAIN
        @all_mountain_top_skis = []
        @big_mountain_top_skis = []  
        @park_and_pipe_top_skis = []
        @alpine_touring_top_skis = []
        @carving_top_skis = []
        @womens_top_skis = []

        top_reviews.each do |review|  
          all_mountain_top_ski = Ski.where(:ski_type => "All Mountain Skis").where(:id => review.ski_id).where(:gender=>"Men's")
          all_mountain_top_ski.each do |ski_object|
            @all_mountain_top_skis << ski_object
          end
          big_mountain_top_ski = Ski.where(:ski_type => "Big Mountain Skis").where(:id => review.ski_id).where(:gender=>"Men's")
          big_mountain_top_ski.each do |ski_object|
            @big_mountain_top_skis << ski_object
          end
          park_and_pipe_top_ski = Ski.where(:ski_type => "Park & Pipe Skis").where(:id => review.ski_id).where(:gender=>"Men's")
          park_and_pipe_top_ski.each do |ski_object|
            @park_and_pipe_top_skis << ski_object
          end
          alpine_touring_top_ski = Ski.where(:ski_type => "Alpine Touring Skis").where(:id => review.ski_id).where(:gender=>"Men's")
          alpine_touring_top_ski.each do |ski_object|
            @alpine_touring_top_skis << ski_object
          end
          carving_top_ski = Ski.where(:ski_type => "Carving Skis").where(:id => review.ski_id).where(:gender=>"Men's")
          carving_top_ski.each do |ski_object|
            @carving_top_skis << ski_object
          end
          womens_top_ski = Ski.where(:id => review.ski_id).where(:gender=>"Women's")
          womens_top_ski.each do |ski_object|
            @womens_top_skis << ski_object  
          end
        end
    	end
	

  def learn
  end

  def about
  end

  def blog
  end
  
  end 

end
