require 'rails_helper'

RSpec.describe "garden_items/index", :type => :view do
  before(:each) do
    assign(:garden_items, [
      GardenItem.create!(
        :quantity => 1
      ),
      GardenItem.create!(
        :quantity => 1
      )
    ])
  end

  it "renders a list of garden_items" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
