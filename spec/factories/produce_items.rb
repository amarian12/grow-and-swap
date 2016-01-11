FactoryGirl.define do
  factory :produce_item do
    name "carrot"
    category "Vegetable"

    trait :produce_item_with_garden_items do
      # factory_girl_rails '~>4.0' uses ignore method; '5.0' uses transient
      ignore do
        garden_items_count 5
      end

      after(:create) do |produce_item, evaluator|
        create_list(:garden_item, evaluator.garden_items_count, produce_item: produce_item)
      end
    end
  end
end
