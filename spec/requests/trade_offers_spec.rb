require 'rails_helper'

RSpec.describe "TradeOffers", :type => :request do
  describe "GET /trade_offers" do
    it "works! (now write some real specs)" do
      get trade_offers_path
      expect(response).to have_http_status(200)
    end
  end
end
