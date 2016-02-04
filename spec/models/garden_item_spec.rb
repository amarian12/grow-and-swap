require 'rails_helper'

RSpec.describe GardenItem, :type => :model do
  describe "Validations" do
    it "is invalid without a quantity" do
      garden_item = GardenItem.new(quantity: nil)
      garden_item.valid?
      expect(garden_item.errors[:quantity]).to include("can't be blank")
    end

    it "validates presence of user" do
      is_expected.to validate_presence_of :user
    end

    it "validates presence of produce item" do
      is_expected.to validate_presence_of :produce_item
    end
  end

  describe "Associations" do
    it "belongs to user" do
      is_expected.to belong_to :user
    end

    it "belongs to produce item" do
      is_expected.to belong_to :produce_item
    end
  end
end
