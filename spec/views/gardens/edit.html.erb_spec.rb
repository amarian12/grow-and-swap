require 'rails_helper'

RSpec.describe "gardens/edit", :type => :view do
  before(:each) do
    @garden = assign(:garden, Garden.create!(
      :quantity => 1
    ))
  end

  it "renders the edit garden form" do
    render

    assert_select "form[action=?][method=?]", garden_path(@garden), "post" do

      assert_select "input#garden_quantity[name=?]", "garden[quantity]"
    end
  end
end
