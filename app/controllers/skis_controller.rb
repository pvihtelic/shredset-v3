class SkisController < ApplicationController
  # GET /skis
  # GET /skis.json
  def index
    @skis = Ski.scoped

    if params[:ski].present?

      @ski_type = params[:ski][:ski_type].reject(&:blank?)
      @gender = params[:ski][:gender].reject(&:blank?)
      @ability_level = params[:ski][:ability_level].reject(&:blank?)
      @brand = params[:brand][:company].reject(&:blank?)
      @price_range = params[:price_range][:price_range]
      # raise ski_type.any?.inspect
      
      @inventories = Inventory.scoped

      @skis_array = []
      if @price_range.include? "-200"
        inventories = @inventories.where(:price => 0..200)
        inventories.each do |inventory|
          ski_in_price_range = inventory.ski
          @skis_array << ski_in_price_range
        end
      elsif @price_range.include? "200-400"
        inventories = @inventories.where(:price => 200..400)
        inventories.each do |inventory|
          ski_in_price_range = inventory.ski
          @skis_array << ski_in_price_range
        end
      elsif @price_range.include? "400-600"
        inventories = @inventories.where(:price => 400..600)
        inventories.each do |inventory|
          ski_in_price_range = inventory.ski
          @skis_array << ski_in_price_range
        end
      elsif @price_range.include? "600-800"
        inventories = @inventories.where(:price => 600..800)
        inventories.each do |inventory|
          ski_in_price_range = inventory.ski
          @skis_array << ski_in_price_range
        end
      elsif @price_range.include? "800-1000"
        inventories = @inventories.where(:price => 800..1000)
        inventories.each do |inventory|
          ski_in_price_range = inventory.ski
          @skis_array<< ski_in_price_range
        end
      elsif @price_range.include? "1000+"
        inventories = @inventories.where(:price => 1000..2000)
        inventories.each do |inventory|
          ski_in_price_range = inventory.ski
          @skis_array << ski_in_price_range
        end
      end

      if @ski_type.any?
        @skis = @skis.where(:ski_type => @ski_type)
      end
      if @gender.any?
        @skis = @skis.where(:gender => @gender)
      end
      if @ability_level.any?
        @skis = @skis.where(:ability_level => @ability_level)
      end
      if @brand.any?
         @skis = @skis.where(:brand_id => @brand)
      end

      @overlapping_skis = @skis_array & @skis

      # @skis = @skis.where(:ski_type => ski_type) if ski_type.any?
      # @skis = @skis.where(:gender => gender) if gender.any?
      # @skis = @skis.where(:ability_level => ability_level) if ability_level.any?
      # @skis = @skis.where(:brand_id => brand) if brand.any?

     end 

      # @skis = Ski.where(:ski_type => ski_type[1], :gender => gender[1], :ability_level => ability_level[1], :brand_id => brand[1])
      # if !ski_type[1].blank?

      # @skis2 = Ski.where(:gender => gender[1]) if !gender[1].blank?
      # @skis3 = Ski.where(:ability_level => ability_level[1]) if !ability_level[1].blank?

      # @skis = []
      # if !@skis1.nil?
      #   @skis.concat(@skis1)
      # end
      # if !@skis2.nil? 
      #   @skis.concat(@skis2)
      # end
      # if !@skis3.nil?
      #   @skis.concat(@skis3)
      # end
    # end



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
