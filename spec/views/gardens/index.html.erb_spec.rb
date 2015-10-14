require 'rails_helper'

RSpec.describe "gardens/index", :type => :view do
  before(:each) do
    assign(:gardens, [
      Garden.create!(
        :quantity => 1
      ),
      Garden.create!(
        :quantity => 1
      )
    ])
  end

  it "renders a list of gardens" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
