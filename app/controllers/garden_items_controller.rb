class GardenItemsController < ApplicationController
  before_action :set_garden_item, only: [:show, :edit, :update, :destroy]

  # GET /garden_items
  # GET /garden_items.json
  def index
    @garden_items = GardenItem.all
  end

  # GET /garden_items/1
  # GET /garden_items/1.json
  def show
  end

  # GET /garden_items/new
  def new
    @garden_item = GardenItem.new
  end

  # GET /garden_items/1/edit
  def edit
  end

  # POST /garden_items
  # POST /garden_items.json
  def create
    @garden_item = GardenItem.new(garden_item_params)

    respond_to do |format|
      if @garden_item.save
        format.html { redirect_to @garden_item, notice: 'garden_item was successfully created.' }
        format.json { render :show, status: :created, location: @garden_item }
      else
        format.html { render :new }
        format.json { render json: @garden_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /garden_items/1
  # PATCH/PUT /garden_items/1.json
  def update
    respond_to do |format|
      if @garden_item.update(garden_item_params)
        format.html { redirect_to @garden_item, notice: 'garden_item was successfully updated.' }
        format.json { render :show, status: :ok, location: @garden_item }
      else
        format.html { render :edit }
        format.json { render json: @garden_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /garden_items/1
  # DELETE /garden_items/1.json
  def destroy
    @garden_item.destroy
    respond_to do |format|
      format.html { redirect_to garden_items_url, notice: 'garden_item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_garden_item
      @garden_item = garden_item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def garden_item_params
      params.require(:garden_item).permit(:quantity, produce_item_attributes: [:name, :category])
    end
end
