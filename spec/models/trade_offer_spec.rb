require 'rails_helper'

RSpec.describe TradeOffer, :type => :model do
  describe "Validations" do
    it "is invalid without a quantity" do
      trade_offer = TradeOffer.new(quantity: nil)
      trade_offer.valid?
      expect(trade_offer.errors[:quantity]).to include("can't be blank")
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
      is_expected.to belong_to(:buyer).
      class_name("User").
      with_foreign_key(:user_id)
    end

    it "belongs to garden item" do
      is_expected.to belong_to(:garden_item).with_foreign_key(:garden_item_id)
    end

    it "has one seller through garden item" do
      is_expected.to have_one(:seller).
      class_name("User").
      through(:garden_item)
    end

    it "belongs to initial trade offer" do
      is_expected.to belong_to(:initial_trade_offer).
      class_name("TradeOffer").
      with_foreign_key(:initial_trade_offer_id)
    end
  end
end
