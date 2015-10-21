FactoryGirl.define do
  factory :garden_item do
    factory :garden_item_with_produce_items do
      # factory_girl_rails '~>4.0' uses ignore method; '5.0' uses transient
      ignore do
        produce_items_count 5
      end

      after(:create) do |garden_item, evaluator|
        create_list(:produce_item, evaluator.produce_items_count, garden_item: garden_item)
      end
    end
  end
end
