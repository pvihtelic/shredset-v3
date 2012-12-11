class SkisController < ApplicationController
  # GET /skis
  # GET /skis.json
  def index

    @companies = Brand.scoped
    @ski_types = Ski.find(:all, :select => "DISTINCT ski_type")
    @genders = Ski.find(:all, :select => "DISTINCT gender")
    @names = Ski.find(:all, :select => "DISTINCT name")
    @price_ranges = PriceRange.scoped
    @model_years = Ski.find(:all, :select => "DISTINCT model_year")
    @sorts = ["Price", "Rating", "Availability"]

    if params[:ski].present? || params[:brand].present? || params[:price_range].present?
    # Creates references for collection select
    
      ski_type = params[:ski][:ski_type].reject(&:blank?)
      gender = params[:ski][:gender].reject(&:blank?)
      company = params[:brand][:company].reject(&:blank?)
      name = params[:ski][:name].reject(&:blank?)
      price_range = params[:price_range][:price_range]
      model_year = params[:ski][:model_year].reject(&:blank?)
      # raise ski_type.any?.inspect

      @ski = Ski.new
      @ski.ski_type = ski_type
      @ski.gender = gender
      @ski.name = name
      @ski.model_year = model_year

      @price_range = PriceRange.new
      @price_range.price_range = price_range

      @brand = Brand.new
      @brand.company = company

      skis = Inventory.search_price(price_range)

      skis_refined = Ski.search_characteristics(ski_type, gender, company, name, model_year)

      ski_ids2 = skis.map(&:id) & skis_refined.map(&:id)

      @all_skis = Ski.where(:id => ski_ids2)

      if params[:sort_by] == "Price"
        @overlapping_skis = @all_skis.joins(:inventories).order("inventories.price ASC").page(params[:page])
      elsif params[:sort_by] == "Rating"
        @overlapping_skis = @all_skis.joins(:reviews).order("reviews.average_review DESC").page(params[:page])
      else
        @overlapping_skis = @all_skis.joins(:brand).order("brands.company ASC, skis.model_year DESC, skis.name ASC").page(params[:page])
      end
      
    else
      @overlapping_skis = Ski.joins(:brand).order("brands.company ASC, skis.model_year DESC, skis.name ASC").page(params[:page])
    end


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @skis }
    end
  end

  # GET /skis/1
  # GET /skis/1.json
  def show
    @ski = Ski.find(params[:id])

    @inventory = Inventory.where(:ski_id => params[:id])

    @image = Image.where(:ski_id => params[:id])

    @spec = Spec.where(:ski_id => params[:id])

    @stores_array = [] 
    @inventory.each do |inventory|
      if !@stores_array.include? inventory.store 
        @stores_array.push inventory.store
      end
    end

    @images = Image.where(:ski_id => params[:id])

    @reviews = Review.where(:ski_id => params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ski }
    end
  end

  # GET /skis/new
  # GET /skis/new.json
  def new
    @ski = Ski.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ski }
    end
  end

  # GET /skis/1/edit
  def edit
    @ski = Ski.find(params[:id])
  end

  # POST /skis
  # POST /skis.json
  def create
    @ski = Ski.new(params[:ski])

    respond_to do |format|
      if @ski.save
        format.html { redirect_to @ski, notice: 'Ski was successfully created.' }
        format.json { render json: @ski, status: :created, location: @ski }
      else
        format.html { render action: "new" }
        format.json { render json: @ski.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /skis/1
  # PUT /skis/1.json
  def update
    @ski = Ski.find(params[:id])

    respond_to do |format|
      if @ski.update_attributes(params[:ski])
        format.html { redirect_to @ski, notice: 'Ski was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ski.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /skis/1
  # DELETE /skis/1.json
  def destroy
    @ski = Ski.find(params[:id])
    @ski.destroy

    respond_to do |format|
      format.html { redirect_to skis_url }
      format.json { head :no_content }
    end
  end
end
