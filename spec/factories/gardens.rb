FactoryGirl.define do
  factory :garden do
    factory :garden_with_produce_items do
      # factory_girl_rails '~>4.0' uses ignore method; '5.0' uses transient
      ignore do
        produce_items_count 5
      end

      after(:create) do |garden, evaluator|
        create_list(:produce_item, evaluator.produce_items_count, garden: garden)
      end
    end
  end
end
