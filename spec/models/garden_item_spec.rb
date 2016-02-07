require 'rails_helper'

RSpec.describe GardenItem, :type => :model do
  describe "Validations" do
    it "is invalid without a quantity" do
      garden_item = GardenItem.new(quantity: nil)
      garden_item.valid?
      expect(garden_item.errors[:quantity]).to include("can't be blank")
    end

    it "validates presence of user" do
      is_expected.to validate_presence_of :seller
    end

    it "validates presence of produce item" do
      is_expected.to validate_presence_of :produce_item
    end
  end

  describe "Associations" do
    it "belongs to seller" do
      is_expected.to belong_to :seller
    end

    it "belongs to produce item" do
      is_expected.to belong_to :produce_item
    end

    it "has many trade offers" do
      is_expected.to have_many :trade_offers
    end

    it "has many buyers through trade offers" do
      is_expected.to have_many :buyers
    end
  end
end
