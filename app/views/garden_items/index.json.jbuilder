json.array!(@garden_items) do |garden_item|
  json.extract! garden_item, :id, :quantity
  json.url garden_item_url(garden_item, format: :json)
end
