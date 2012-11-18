class PagesController < ApplicationController

	def home
		@skis = Ski.all

    	respond_to do |format|
     	format.html # index.html.erb
      	format.json { render json: @skis }
    	end
	end

end
