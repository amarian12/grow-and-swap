require 'rails_helper'

RSpec.describe "produce_items/edit", :type => :view do
  before(:each) do
    @produce_item = assign(:produce_item, ProduceItem.create!(
      :name => "MyString",
      :category => "MyString"
    ))
  end

  it "renders the edit produce_item form" do
    render

    assert_select "form[action=?][method=?]", produce_item_path(@produce_item), "post" do

      assert_select "input#produce_item_name[name=?]", "produce_item[name]"

      assert_select "input#produce_item_category[name=?]", "produce_item[category]"
    end
  end
end
