FactoryGirl.define do
  factory :trade_offer, aliases: [:trade_offer_made, :trade_offer_received] do
    quantity 6
    accepted false
    buyer
    garden_item
    initial_trade_offer
  end

  factory :initial_trade_offer, class: TradeOffer do
    quantity 6
    accepted false
    buyer
    garden_item
  end
end
