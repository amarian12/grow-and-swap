require 'pry'

class GardenItemsController < ApplicationController
  before_action :set_garden_item, only: [:show, :edit, :update, :destroy]

  def index
    @garden_items = GardenItem.all
  end

  def show
  end

  def new
    @garden_item = GardenItem.new
  end

  def edit
  end

  def create
    # @garden_item = GardenItem.new(garden_item_params)
    # produce_item = ProduceItem.find(params[:produce_item_id])
    @garden_item = current_user.garden_items.build(garden_item_params)
    # binding.pry
    @garden_item.produce_item = ProduceItem.find(params[:garden_item][:produce_item_id].to_i)

    respond_to do |format|
      if @garden_item.save
        format.html { redirect_to @garden_item, notice: 'Garden item was successfully created.' }
        format.json { render :show, status: :created, location: @garden_item }
      else
        format.html { render :new }
        format.json { render json: @garden_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @garden_item.update(garden_item_params)
        format.html { redirect_to @garden_item, notice: 'Garden item was successfully updated.' }
        format.json { render :show, status: :ok, location: @garden_item }
      else
        format.html { render :edit }
        format.json { render json: @garden_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @garden_item.destroy
    respond_to do |format|
      format.html { redirect_to garden_items_url, notice: 'Garden item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_garden_item
    @garden_item = GardenItem.find(params[:id])
  end

  def garden_item_params
    params.require(:garden_item).permit(:quantity, produce_item_attributes: [:id, :name, :category])
  end
end
