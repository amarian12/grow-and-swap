namespace :produce_items do
  desc "Seed produce items"
  task seed_produce_items: :environment do
    ProduceItem.create!([{
      name: "Carrot", category: "Vegetable"
    },
    {
      name: "Potato", category: "Vegetable"
    },
    {
      name: "Squash", category: "Vegetable"
    },
    {
      name: "Cucumber", category: "Vegetable"
    },
    {
      name: "Zucchini", category: "Vegetable"
    },
    {
      name: "Eggplant", category: "Vegetable"
    },
    {
      name: "Strawberry", category: "Fruit"
    },
    {
      name: "Apple", category: "Fruit"
    },
    {
      name: "Tomato", category: "Fruit"
    },
    {
      name: "Pear", category: "Fruit"
    },
    {
      name: "Tomatillo", category: "Fruit"
    },
    {
      name: "Lettuce", category: "Vegetable"
    },
    {
      name: "Spinach", category: "Vegetable"
    },
    {
      name: "Cabbage", category: "Vegetable"
    },
    {
      name: "Kale", category: "Vegetable"
    },
    {
      name: "Broccoli", category: "Vegetable"
    },
    {
      name: "Cauliflower", category: "Vegetable"
    }])
  end
end
