require 'rails_helper'

RSpec.describe "trade_offers/edit", :type => :view do
  before(:each) do
    @trade_offer = assign(:trade_offer, TradeOffer.create!(
      :quantity => 1,
      :accepted => false
    ))
  end

  it "renders the edit trade_offer form" do
    render

    assert_select "form[action=?][method=?]", trade_offer_path(@trade_offer), "post" do

      assert_select "input#trade_offer_quantity[name=?]", "trade_offer[quantity]"

      assert_select "input#trade_offer_accepted[name=?]", "trade_offer[accepted]"
    end
  end
end
