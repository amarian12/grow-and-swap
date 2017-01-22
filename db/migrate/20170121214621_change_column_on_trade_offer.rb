class ChangeColumnOnTradeOffer < ActiveRecord::Migration
  def change
    rename_column :trade_offers, :reciprocal_trade_offer, :reciprocal_trade_offer_id
  end
end
