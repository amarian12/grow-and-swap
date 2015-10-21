require 'rails_helper'

RSpec.describe Garden, :type => :model do
  let(:garden) do
    garden = create(:garden)
    Garden.find garden.id
  end

  let(:produce_item) do
    produce_item = garden.produce_items.create(:produce_item)
    ProduceItem.find produce_item.id
  end

  let(:produce_items) do
    create(:garden_with_produce_items)
  end

  describe "Validations" do
    it "is invalid without a quantity" do
      garden = Garden.new(quantity: nil)
      garden.valid?
      expect(garden.errors[:quantity]).to include("can't be blank")
    end
  end

  describe "Default produce item quantity" do
    it "has a default of 0" do
      # produce_item = garden.produce_items.create()
      binding.pry
      expect(produce_items.find(1).quantity).to eq 0
    end
  end
end
