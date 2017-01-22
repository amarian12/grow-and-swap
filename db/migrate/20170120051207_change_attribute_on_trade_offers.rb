class ChangeAttributeOnTradeOffers < ActiveRecord::Migration
  def change
    rename_column :trade_offers, :initial_trade_offer_id, :reciprocal_trade_offer_id
  end
end
