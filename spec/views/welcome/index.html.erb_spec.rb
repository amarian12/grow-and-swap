require 'rails_helper'

RSpec.describe "welcome/index.html.erb", :type => :view do
  context "when not logged in" do
    it "displays only one button" do
      render

      expect(rendered).to have_link("Browse garden items in your area")
      expect(rendered).to_not have_link("My trade offers")
      expect(rendered).to_not have_link("View produce items inventory")
    end
  end
end
