class ChangeTradeOfferColumn < ActiveRecord::Migration
  def change
    rename_column :trade_offers, :reciprocal_trade_offer_id, :reciprocal_trade_offer
  end
end
