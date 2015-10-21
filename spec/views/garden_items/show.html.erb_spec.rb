require 'rails_helper'

RSpec.describe "garden_items/show", :type => :view do
  before(:each) do
    @garden_item = assign(:garden_item, GardenItem.create!(
      :quantity => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
  end
end
