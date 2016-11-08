require "rails_helper"

RSpec.describe GardenItemsController, :type => :routing do
  describe "routing" do
    it "routes to #current_user_index" do
      expect(:get => "/garden_items/current_user_index").to route_to("garden_items#current_user_index")
    end

    it "routes to #index" do
      expect(:get => "/garden_items").to route_to("garden_items#index")
    end

    it "routes to #new" do
      expect(:get => "/garden_items/new").to route_to("garden_items#new")
    end

    it "routes to #show" do
      expect(:get => "/garden_items/1").to route_to("garden_items#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/garden_items/1/edit").to route_to("garden_items#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/garden_items").to route_to("garden_items#create")
    end

    it "routes to #update" do
      expect(:put => "/garden_items/1").to route_to("garden_items#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/garden_items/1").to route_to("garden_items#destroy", :id => "1")
    end
  end
end
