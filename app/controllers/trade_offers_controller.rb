class TradeOffersController < ApplicationController
  before_action :set_trade_offer, only: [:show, :edit, :update, :destroy]

  # GET /trade_offers
  # GET /trade_offers.json
  def index
    @trade_offers = TradeOffer.all
  end

  # GET /trade_offers/1
  # GET /trade_offers/1.json
  def show
  end

  # GET /trade_offers/new
  def new
    @trade_offer = TradeOffer.new
  end

  # GET /trade_offers/1/edit
  def edit
  end

  # POST /trade_offers
  # POST /trade_offers.json
  def create
    @trade_offer = TradeOffer.new(trade_offer_params)

    respond_to do |format|
      if @trade_offer.save
        format.html { redirect_to @trade_offer, notice: 'Trade offer was successfully created.' }
        format.json { render :show, status: :created, location: @trade_offer }
      else
        format.html { render :new }
        format.json { render json: @trade_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trade_offers/1
  # PATCH/PUT /trade_offers/1.json
  def update
    respond_to do |format|
      if @trade_offer.update(trade_offer_params)
        format.html { redirect_to @trade_offer, notice: 'Trade offer was successfully updated.' }
        format.json { render :show, status: :ok, location: @trade_offer }
      else
        format.html { render :edit }
        format.json { render json: @trade_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trade_offers/1
  # DELETE /trade_offers/1.json
  def destroy
    @trade_offer.destroy
    respond_to do |format|
      format.html { redirect_to trade_offers_url, notice: 'Trade offer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trade_offer
      @trade_offer = TradeOffer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trade_offer_params
      params.require(:trade_offer).permit(:quantity, :accepted)
    end
end
