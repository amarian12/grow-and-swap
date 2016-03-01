class AddInitialTradeOfferRefToTradeOffer < ActiveRecord::Migration
  def change
    add_reference :trade_offers, :initial_trade_offer, index: true
  end
end
