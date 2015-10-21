require 'rails_helper'

RSpec.describe "garden_items/new", :type => :view do
  before(:each) do
    assign(:garden_item, GardenItem.new(
      :quantity => 1
    ))
  end

  it "renders new garden_item form" do
    render

    assert_select "form[action=?][method=?]", garden_items_path, "post" do

      assert_select "input#garden_item_quantity[name=?]", "garden_item[quantity]"
    end
  end
end
