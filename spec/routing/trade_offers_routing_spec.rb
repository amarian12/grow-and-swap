require "rails_helper"

RSpec.describe TradeOffersController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/trade_offers").to route_to("trade_offers#index")
    end

    it "routes to #new" do
      expect(:get => "/trade_offers/new").to route_to("trade_offers#new")
    end

    it "routes to #show" do
      expect(:get => "/trade_offers/1").to route_to("trade_offers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/trade_offers/1/edit").to route_to("trade_offers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/trade_offers").to route_to("trade_offers#create")
    end

    it "routes to #update" do
      expect(:put => "/trade_offers/1").to route_to("trade_offers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/trade_offers/1").to route_to("trade_offers#destroy", :id => "1")
    end

  end
end
