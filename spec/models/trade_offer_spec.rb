require 'rails_helper'

RSpec.describe TradeOffer, :type => :model do
  describe "Validations" do
    it "is invalid without a quantity" do
      trade_offer = TradeOffer.new(quantity: nil)
      trade_offer.valid?
      expect(trade_offer.errors[:quantity]).to include("can't be blank")
    end

    it "is invalid without an accepted value" do
      trade_offer = TradeOffer.new(accepted: nil)
      trade_offer.valid?
      expect(trade_offer.errors[:accepted]).to include("can't be blank")
    end

    it "validates presence of buyer" do
      is_expected.to validate_presence_of :buyer
    end

    it "validates presence of garden item" do
      is_expected.to validate_presence_of :garden_item
    end
  end

  describe "Associations" do
    it "belongs to buyer" do
      is_expected.to belong_to :buyer
    end

    it "belongs to garden item" do
      is_expected.to belong_to :garden_item
    end

    it "has one seller through garden item" do
      is_expected.to have_one :seller
    end
  end
end
