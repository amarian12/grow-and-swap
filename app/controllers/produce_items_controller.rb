class ProduceItemsController < ApplicationController
  before_action :set_produce_item,  only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user

  def index
    @produce_items = ProduceItem.order(:name).all
  end

  def show
  end

  def new
    @produce_item = ProduceItem.new
  end

  def edit
  end

  def create
    @produce_item = ProduceItem.new(produce_item_params)

    respond_to do |format|
      if @produce_item.save
        format.html { redirect_to produce_items_path, notice: 'Produce item was successfully created.' }
        format.json { render :index, status: :created, location: @produce_item }
      else
        format.html { render :new }
        format.json { render json: @produce_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @produce_item.update(produce_item_params)
        format.html { redirect_to produce_items_path, notice: 'Produce item was successfully updated.' }
        format.json { render :index, status: :ok, location: @produce_item }
      else
        format.html { render :edit }
        format.json { render json: @produce_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @produce_item.destroy
    respond_to do |format|
      format.html { redirect_to produce_items_url, notice: 'Produce item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_produce_item
      @produce_item = ProduceItem.find(params[:id])
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in"
        redirect_to login_path
      end
    end

    def produce_item_params
      params.require(:produce_item).permit(:name, :category, :photo)
    end
end
