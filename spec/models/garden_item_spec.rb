require 'rails_helper'

RSpec.describe GardenItem, :type => :model do
  let(:garden_item) do
    garden_item = create(:garden_item)
    GardenItem.find garden.id
  end

  let(:produce_item) do
    produce_item = garden_item.produce_items.create(:produce_item)
    ProduceItem.find produce_item.id
  end

  let(:produce_items) do
    create(:garden_item_with_produce_items)
  end

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

  describe "Default produce item quantity" do
    it "has a default of 0" do
      # produce_item = garden.produce_items.create()
      expect(produce_items.find(1).quantity).to eq 0
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

  describe "Nested attributes" do
    it "accepts nested attributes for produce_item" do
      is_expected.to accept_nested_attributes_for :produce_item
    end
  end
end
