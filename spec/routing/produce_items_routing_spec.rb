require "rails_helper"

RSpec.describe ProduceItemsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/gardens/1/produce_items").to route_to("produce_items#index", :garden_id => "1")
    end

    it "routes to #new" do
      expect(:get => "/gardens/1/produce_items/new").to route_to("produce_items#new", :garden_id => "1")
    end

    it "routes to #show" do
      expect(:get => "/gardens/1/produce_items/1").to route_to("produce_items#show", :garden_id => "1", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/gardens/1/produce_items/1/edit").to route_to("produce_items#edit", :garden_id => "1", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/gardens/1/produce_items").to route_to("produce_items#create", :garden_id => "1")
    end

    it "routes to #update" do
      expect(:put => "/gardens/1/produce_items/1").to route_to("produce_items#update", :garden_id => "1", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/gardens/1/produce_items/1").to route_to("produce_items#destroy", :garden_id => "1", :id => "1")
    end

  end
end
