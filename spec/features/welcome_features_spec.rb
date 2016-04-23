require 'rails_helper'

RSpec.feature "Welcome page features", :type => :feature do
  given(:user) { user = create(:user) }
  given(:admin) { admin = create(:admin) }

  context "When not logged in" do
    background do
      visit '/'
    end

    scenario "Visiting home page shows welcome page" do
      expect(page).to have_text("Welcome to Grow and Swap")
    end

    scenario "Visitor can browse garden items" do
      click_link "Browse garden items in your area"
      expect(current_path).to eq(garden_items_path)
    end
  end

  context "When logged in as non-admin user" do
    background do
      log_in_with(user)
      visit '/'
    end

    scenario "User can browse garden items" do
      click_link "Browse garden items in your area"
      expect(current_path).to eq(garden_items_path)
    end

    scenario "User can view their trade offers" do
      click_link "My trade offers"
      expect(current_path).to eq(trade_offers_path)
    end

    scenario "Non-admin user can't see 'View produce items inventory' button" do
      expect(page).to_not have_link "View produce items inventory"
    end
  end

  context "When logged in as admin user" do
    scenario "Admin user can view produce items inventory" do
      log_in_with(admin)
      visit '/'
      click_link "View produce items inventory"
      expect(current_path).to eq(produce_items_path)
    end
  end
end
