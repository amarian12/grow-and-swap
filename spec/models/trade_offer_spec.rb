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

    it "validates presence of user" do
      is_expected.to validate_presence_of :user
    end

    it "validates presence of garden item" do
      is_expected.to validate_presence_of :garden_item
    end
  end

  describe "Associations" do
    it "belongs to user" do
      is_expected.to belong_to :user
    end

    it "belongs to garden item" do
      is_expected.to belong_to :garden_item
    end
  end
end
