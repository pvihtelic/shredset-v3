class SpecsController < ApplicationController
  # GET /specs
  # GET /specs.json
  def index
    @specs = Spec.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @specs }
    end
  end

  # GET /specs/1
  # GET /specs/1.json
  def show
    @spec = Spec.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @spec }
    end
  end

  # GET /specs/new
  # GET /specs/new.json
  def new
    @spec = Spec.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @spec }
    end
  end

  # GET /specs/1/edit
  def edit
    @spec = Spec.find(params[:id])
  end

  # POST /specs
  # POST /specs.json
  def create
    @spec = Spec.new(params[:spec])

    respond_to do |format|
      if @spec.save
        format.html { redirect_to @spec, notice: 'Spec was successfully created.' }
        format.json { render json: @spec, status: :created, location: @spec }
      else
        format.html { render action: "new" }
        format.json { render json: @spec.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /specs/1
  # PUT /specs/1.json
  def update
    @spec = Spec.find(params[:id])

    respond_to do |format|
      if @spec.update_attributes(params[:spec])
        format.html { redirect_to @spec, notice: 'Spec was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @spec.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /specs/1
  # DELETE /specs/1.json
  def destroy
    @spec = Spec.find(params[:id])
    @spec.destroy

    respond_to do |format|
      format.html { redirect_to specs_url }
      format.json { head :no_content }
    end
  end
end
