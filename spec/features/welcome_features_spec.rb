require 'rails_helper'

RSpec.feature "Welcome page", :type => :feature do
  background do
    @user = create(:user)
    User.find @user.id
  end

  scenario "visitor can browse produce items" do
    visit '/'
    click_link 'Browse produce items in your area'
    expect(current_path).to eq(garden_items_path)
  end

  scenario "logged in user can browse produce items" do
    log_in_with(@user)
    visit '/'
    click_link 'Browse produce items in your area'
    expect(current_path).to eq(garden_items_path)
  end

  scenario "find text" do
    visit '/'
    expect(page).to have_text("Welcome to Grow and Swap")
  end
end
