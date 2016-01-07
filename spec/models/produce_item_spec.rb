require 'rails_helper'

RSpec.describe ProduceItem, :type => :model do
  describe "Validations" do
    it "is invalid without a name" do
      produce_item = ProduceItem.new(name: nil)
      produce_item.valid?
      expect(produce_item.errors[:name]).to include("can't be blank")
    end

    it "is invalid without a category" do
      produce_item = ProduceItem.new(category: nil)
      produce_item.valid?
      expect(produce_item.errors[:category]).to include("can't be blank")
    end
  end

  describe "Associations" do
    it "has many garden items" do
      is_expected.to have_many :garden_items
    end

    it "has many users through garden items" do
      is_expected.to have_many(:users).through(:garden_items)
    end
  end
end
