json.array!(@trade_offers) do |trade_offer|
  json.extract! trade_offer, :id, :quantity, :accepted
  json.url trade_offer_url(trade_offer, format: :json)
end
