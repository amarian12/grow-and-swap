require 'rails_helper'

RSpec.describe "Garden Items", :type => :request do
  describe "GET /garden_items" do
    it "works! (now write some real specs)" do
      get garden_items_path
      expect(response).to have_http_status(200)
    end
  end
end
