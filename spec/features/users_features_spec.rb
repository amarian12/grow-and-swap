require 'rails_helper'

RSpec.feature User, :type => :feature do
  given(:user) { user = create(:user) }
  given(:admin) { admin = create(:admin) }

  given!(:users) { users = create_list(:user, 5) }

  given!(:garden_item) do
    garden_item = create(:garden_item)
  end

  scenario "Visitor can sign up as new user" do
    visit "/"
    click_link "Sign up"
    fill_in("First name", with: Faker::Name.first_name)
    fill_in("Last name", with: Faker::Name.last_name)
    fill_in("Email", with: Faker::Internet.email)
    fill_in("Password", with: 12345678)
    fill_in("Password confirmation", with: 12345678)
    click_button "Submit"
    expect(page).to have_text "Welcome to Grow and Swap!"
  end

  feature "User garden items" do
    background do
      log_in_with(user)
    end

    scenario "User can view another user's garden items" do
      visit "/users"
      click_link "#{users.first.full_name}"
      expect(page).to have_text "garden items"
    end
  end
end
