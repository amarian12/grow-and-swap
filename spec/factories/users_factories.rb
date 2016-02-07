FactoryGirl.define do
  factory :user, aliases: [:seller] do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { |u| u.password }

    factory :user_with_garden_items do
      # factory_girl_rails '~>4.0' uses ignore method; '5.0' uses transient
      ignore do
        garden_items_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:garden_item, evaluator.garden_items_count, user: user)
      end
    end

    factory :user_with_garden_item do
      ignore do
        produce_item { create :produce_item }
      end

      after(:create) do |user, evaluator|
        user.produce_items << evaluator.produce_item
        user.save
        garden_item = user.garden_items.where(produce_item: evaluator.produce_item).first
        garden_item.save
        user.reload
      end
    end
  end

  factory :admin, class: User do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { |u| u.password }
    admin { true }
  end
end
