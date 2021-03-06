class TradeOffersController < ApplicationController
  before_action :set_trade_offer, only: [:show, :update, :accept, :destroy]
  before_action :logged_in_user

  def index
    @trade_offers_made = current_user.trade_offers_made
    @trade_offers_received = current_user.trade_offers_received
  end

  def show
    @reciprocal_trade_offer = @trade_offer.reciprocal_trade_offer

    # Need to know the id of the initiating trade offer so that the React Chat
    #   component PubNub channel is always the same regardless of which trade
    #   offer is clicked on -- initial or reciprocal.
    if @reciprocal_trade_offer.nil?
      initial_trade_offer_id = @trade_offer.id
    else
      initial_trade_offer_id = [@trade_offer.id, @reciprocal_trade_offer.id].min
    end

    # Initial state for react_on_rails component
    @chat_props = { channel:    "trade_offer_#{initial_trade_offer_id}",
                    messages:   { messageList: [], lastMessageTimestamp: nil },
                    newMessage: ""
                  }
    redux_store("chatStore", props: @chat_props)
  end

  def new
    @garden_item = GardenItem.find(params[:garden_item_id])
    @trade_offer = TradeOffer.new(garden_item_id: @garden_item.id)
  end

  def edit
    @garden_item = GardenItem.find(params[:garden_item_id])
    @trade_offer = TradeOffer.find(params[:id])
  end

  def create
    @trade_offer = current_user.trade_offers_made.build(trade_offer_params)
    @trade_offer.garden_item = GardenItem.find(params[:trade_offer][:garden_item_id].to_i)
    if session[:reciprocal_trade_offer_id].present?
      @reciprocal_trade_offer = TradeOffer.find(session[:reciprocal_trade_offer_id])
      @trade_offer.reciprocal_trade_offer = @reciprocal_trade_offer
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

    if session[:reciprocal_trade_offer_id].present?
      @reciprocal_trade_offer.update(reciprocal_trade_offer_id: @trade_offer.id)
      session[:reciprocal_trade_offer_id] = nil
    end
  end

  def update
    respond_to do |format|
      if @trade_offer.update_attribute(:quantity, params[:trade_offer][:quantity])
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
      if @trade_offer.update_attribute(:accepted, params[:trade_offer][:accepted])
        format.js {}
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
      :quantity, :accepted, :user_id, :garden_item_id, :reciprocal_trade_offer_id
    )
  end
end
