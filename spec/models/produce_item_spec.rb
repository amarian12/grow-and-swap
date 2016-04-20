require 'rails_helper'

RSpec.describe ProduceItem, :type => :model do
  let(:produce_item) { produce_item = create(:produce_item) }

  describe "Validations" do
    it "is invalid without a name" do
      produce_item = ProduceItem.new(name: nil)
      produce_item.valid?
      expect(produce_item.errors[:name]).to include("can't be blank")
    end

    it "is invalid with a duplicate name regardless of case" do
      produce_item = create(:produce_item)
      produce_item = ProduceItem.new(name: produce_item.name, category: produce_item.category)
      produce_item.valid?
      expect(produce_item.errors[:name]).to include("has already been taken")
    end

    it "is invalid without a category" do
      produce_item = ProduceItem.new(category: nil)
      produce_item.valid?
      expect(produce_item.errors[:category]).to include("can't be blank")
    end
  end

  describe "Callbacks" do
    it "capitalizes each word in name attribute" do
      produce_item = ProduceItem.create!(name: "carrot", category: "Vegetable")
      expect(produce_item.name).to eq "Carrot"
    end
  end

  describe "Associations" do
    it "has many garden items" do
      is_expected.to have_many :garden_items
    end

    it "has many sellers through garden items" do
      is_expected.to have_many(:sellers).through(:garden_items)
    end
  end
end
