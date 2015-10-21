require 'rails_helper'

RSpec.describe "garden_items/edit", :type => :view do
  before(:each) do
    @garden_item = assign(:garden_item, GardenItem.create!(
      :quantity => 1
    ))
  end

  it "renders the edit garden_item form" do
    render

    assert_select "form[action=?][method=?]", garden_item_path(@garden_item), "post" do

      assert_select "input#garden_item_quantity[name=?]", "garden_item[quantity]"
    end
  end
end
