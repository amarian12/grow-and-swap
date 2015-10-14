require 'rails_helper'

RSpec.describe "gardens/show", :type => :view do
  before(:each) do
    @garden = assign(:garden, Garden.create!(
      :quantity => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
  end
end
