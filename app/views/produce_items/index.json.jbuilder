json.array!(@produce_items) do |produce_item|
  json.extract! produce_item, :id, :name, :category
  json.url produce_item_url(produce_item, format: :json)
end
