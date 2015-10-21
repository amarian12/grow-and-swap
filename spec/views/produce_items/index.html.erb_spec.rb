require 'rails_helper'

RSpec.describe "produce_items/index", :type => :view do
  before(:each) do
    assign(:produce_items, [
      ProduceItem.create!(
        :name => "Name",
        :category => "Category"
      ),
      ProduceItem.create!(
        :name => "Name",
        :category => "Category"
      )
    ])
  end

  it "renders a list of produce_items" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Category".to_s, :count => 2
  end
end
