require 'rails_helper'

RSpec.feature "Welcome page features", :type => :feature do
  given(:user) { user = create(:user_with_garden_items) }
  given(:admin) { admin = create(:admin) }

  context "When not logged in" do
    background do
      user
      visit '/'
    end

    scenario "visiting home page shows welcome page" do
      expect(page).to have_text("Welcome to Grow and Swap")
    end

    scenario "visitor can browse garden items" do
      click_link "Browse garden items in your area"
      expect(current_path).to eq(garden_items_path)
    end

    scenario "visitor can't see 'My trade offers' button" do
      expect(page).to_not have_link "My trade offers"
    end

    scenario "visitor can't see 'View produce items inventory' button" do
      expect(page).to_not have_link "View produce items inventory"
    end
  end

  context "When logged in as non-admin user" do
    background do
      log_in_with(user)
      visit '/'
    end

    scenario "view list of other users' garden items" do
      click_link "Browse garden items in your area"
      expect(page).to have_text "Garden Items in Your Area"
    end

    scenario "user can view other gardeners" do
      click_link "View other gardeners"
      expect(current_path).to eq(users_path)
    end

    scenario "user can view their trade offers" do
      click_link "My trade offers"
      expect(current_path).to eq(trade_offers_path)
    end

    scenario "user cannot see produce items inventory button" do
      expect(page).to_not have_link "View produce items inventory"
    end

    scenario "user can view list of their own posted garden items" do
      click_link "My garden items"
      expect(page).to have_text "My Garden Items"
    end
  end

  context "When logged in as admin user" do
    scenario "user can view produce items inventory" do
      log_in_with(admin)
      visit "/"
      click_link "View produce items inventory"
      expect(current_path).to eq(produce_items_path)
    end
  end
end
