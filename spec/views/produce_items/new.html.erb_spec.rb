require 'rails_helper'

RSpec.describe "produce_items/new", :type => :view do
  before(:each) do
    assign(:produce_item, ProduceItem.new(
      :name => "MyString",
      :category => "MyString"
    ))
  end

  it "renders new produce_item form" do
    render

    assert_select "form[action=?][method=?]", produce_items_path, "post" do

      assert_select "input#produce_item_name[name=?]", "produce_item[name]"

      assert_select "input#produce_item_category[name=?]", "produce_item[category]"
    end
  end
end
