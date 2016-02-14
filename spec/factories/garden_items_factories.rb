FactoryGirl.define do
  factory :garden_item, aliases: [:garden_item_selling, :garden_item_buying] do
    quantity 7
    seller
    produce_item
  end
end
