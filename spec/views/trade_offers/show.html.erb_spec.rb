require 'rails_helper'

RSpec.describe "trade_offers/show", :type => :view do
  before(:each) do
    @trade_offer = assign(:trade_offer, TradeOffer.create!(
      :quantity => 1,
      :accepted => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/false/)
  end
end
