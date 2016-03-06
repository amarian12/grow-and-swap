class TradeOffersController < ApplicationController
  before_action :set_trade_offer, only: [:show, :edit, :update, :accept, :destroy]
  before_action :logged_in_user

  def index
    @trade_offers_made = current_user.trade_offers_made
    @trade_offers_received = current_user.trade_offers_received
  end

  def show
  end

  def new
    @garden_item = GardenItem.find(params[:garden_item_id])
    @trade_offer = TradeOffer.new(garden_item_id: @garden_item.id)
  end

  def edit
  end

  def create
    @trade_offer = current_user.trade_offers_made.build(trade_offer_params)
    @trade_offer.garden_item = GardenItem.find(params[:trade_offer][:garden_item_id].to_i)
    if session[:initial_trade_offer_id].present?
      @trade_offer.initial_trade_offer = TradeOffer.find(session[:initial_trade_offer_id])
    end

    respond_to do |format|
      if @trade_offer.save
        format.html { redirect_to @trade_offer, notice: 'Trade offer was successfully created.' }
        format.json { render :show, status: :created, location: @trade_offer }
      else
        format.html { render :new }
        format.json { render json: @trade_offer.errors, status: :unprocessable_entity }
      end
    end
    session[:initial_trade_offer_id] = nil
  end

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

  def accept
    respond_to do |format|
      if params['@trade_offer.initial_trade_offer'].present?
        @trade_offer.update_attribute(:accepted,
        params['@trade_offer.initial_trade_offer'][:accepted])
        format.html { redirect_to @trade_offer, notice: 'Trade offer was successfully updated.' }
        format.json { render :show, status: :ok, location: @trade_offer }
      elsif params['@trade_offer'].present?
        @trade_offer.update_attribute(:accepted, params['@trade_offer'][:accepted])
        format.html { redirect_to @trade_offer, notice: 'Trade offer was successfully updated.' }
        format.json { render :show, status: :ok, location: @trade_offer }
      else
        format.html { redirect_to :back }
        format.json { render json: @trade_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @trade_offer.destroy
    respond_to do |format|
      format.html { redirect_to trade_offers_url, notice: 'Trade offer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_trade_offer
    @trade_offer = TradeOffer.find(params[:id])
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in"
      redirect_to login_path
    end
  end

  def trade_offer_params
    params.require(:trade_offer).permit(
      :quantity, :accepted, :user_id, :garden_item_id, :initial_trade_offer_id
    )
  end
end
