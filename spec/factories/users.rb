FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { |u| u.password }

    trait :user_with_garden_items do
      # factory_girl_rails '~>4.0' uses ignore method; '5.0' uses transient
      ignore do
        garden_items_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:garden_item, evaluator.garden_items_count, user: user)
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
