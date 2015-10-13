class ProduceItemsController < ApplicationController
  before_action :set_produce_item, only: [:show, :edit, :update, :destroy]

  # GET /produce_items
  # GET /produce_items.json
  def index
    @produce_items = ProduceItem.all
  end

  # GET /produce_items/1
  # GET /produce_items/1.json
  def show
  end

  # GET /produce_items/new
  def new
    @produce_item = ProduceItem.new
  end

  # GET /produce_items/1/edit
  def edit
  end

  # POST /produce_items
  # POST /produce_items.json
  def create
    @produce_item = ProduceItem.new(produce_item_params)

    respond_to do |format|
      if @produce_item.save
        format.html { redirect_to @produce_item, notice: 'Produce item was successfully created.' }
        format.json { render :show, status: :created, location: @produce_item }
      else
        format.html { render :new }
        format.json { render json: @produce_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /produce_items/1
  # PATCH/PUT /produce_items/1.json
  def update
    respond_to do |format|
      if @produce_item.update(produce_item_params)
        format.html { redirect_to @produce_item, notice: 'Produce item was successfully updated.' }
        format.json { render :show, status: :ok, location: @produce_item }
      else
        format.html { render :edit }
        format.json { render json: @produce_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /produce_items/1
  # DELETE /produce_items/1.json
  def destroy
    @produce_item.destroy
    respond_to do |format|
      format.html { redirect_to produce_items_url, notice: 'Produce item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_produce_item
      @produce_item = ProduceItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def produce_item_params
      params.require(:produce_item).permit(:name, :category)
    end
end
