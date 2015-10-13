require 'rails_helper'

RSpec.describe "produce_items/show", :type => :view do
  before(:each) do
    @produce_item = assign(:produce_item, ProduceItem.create!(
      :name => "Name",
      :category => "Category"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Category/)
  end
end
