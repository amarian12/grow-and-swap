require 'rails_helper'

RSpec.describe "trade_offers/index", :type => :view do
  before(:each) do
    assign(:trade_offers, [
      TradeOffer.create!(
        :quantity => 1,
        :accepted => false
      ),
      TradeOffer.create!(
        :quantity => 1,
        :accepted => false
      )
    ])
  end

  it "renders a list of trade_offers" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
