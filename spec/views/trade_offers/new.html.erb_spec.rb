require 'rails_helper'

RSpec.describe "trade_offers/new", :type => :view do
  before(:each) do
    assign(:trade_offer, TradeOffer.new(
      :quantity => 1,
      :accepted => false
    ))
  end

  it "renders new trade_offer form" do
    render

    assert_select "form[action=?][method=?]", trade_offers_path, "post" do

      assert_select "input#trade_offer_quantity[name=?]", "trade_offer[quantity]"

      assert_select "input#trade_offer_accepted[name=?]", "trade_offer[accepted]"
    end
  end
end
