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
  end

  describe "Default produce item quantity" do
    it "has a default of 0" do
      # produce_item = garden.produce_items.create()
      expect(produce_items.find(1).quantity).to eq 0
    end
  end
end
