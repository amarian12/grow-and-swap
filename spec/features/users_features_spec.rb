require 'rails_helper'

RSpec.feature User, :type => :feature do
  given(:user) { user = create(:user) }
  given(:admin) { admin = create(:admin) }

  given!(:users) { users = create_list(:user, 5) }

  given!(:garden_item) do
    garden_item = create(:garden_item)
  end

  scenario "visitor can sign up as new user" do
    visit "/"
    click_link "Sign up"
    fill_in("First name", with: Faker::Name.first_name)
    fill_in("Last name", with: Faker::Name.last_name)
    fill_in("Email", with: Faker::Internet.email)
    fill_in("Password", with: 12345678)
    fill_in("Password confirmation", with: 12345678)
    fill_in("Street", with: Faker::Address.street_address)
    fill_in("City", with: Faker::Address.city)
    fill_in("State", with: Faker::Address.state)
    fill_in("Zip code", with: Faker::Address.zip_code)
    fill_in("Country", with: Faker::Address.country)
    click_button "Submit"
    expect(page).to have_text "Welcome to Grow and Swap!"
  end

  context "When logged in as non-admin user" do
    background do
      log_in_with(user)
    end

    scenario "user cannot see edit/delete links for other users" do
      visit "/users/#{users.last.id}"
      expect(page).to_not have_link "Edit"
      expect(page).to_not have_link "Delete"
    end

    scenario "user can edit their account" do
      visit "/users/#{user.id}"
      click_link "Edit"
      fill_in("First name", with: "James")
      fill_in("Last name", with: "Kirk")
      click_button "Submit"
      expect(page).to have_text "User was successfully updated"
    end

    scenario "user can delete their account" do
      visit "/users/#{user.id}"
      click_link "Delete"
      expect(page).to have_text "User was successfully deleted"
    end

    scenario "user can see map with location of user" do
      visit "/users/#{user.id}"
      expect(page).to have_css('div#map')
    end
  end

  context "When logged in as admin user" do
    background do
      log_in_with(admin)
      visit "/users/#{users.last.id}"
    end

    scenario "user can see edit/delete links for other users" do
      expect(page).to have_link "Edit"
      expect(page).to have_link "Delete"
    end

    scenario "user can edit other user accounts" do
      click_link "Edit"
      fill_in("First name", with: "Spock")
      fill_in("Last name", with: "S'chn T'gai")
      click_button "Submit"
      expect(page).to have_text "User was successfully updated"
    end

    scenario "user can delete other user accounts" do
      click_link "Delete"
      expect(page).to have_text "User was successfully deleted"
    end
  end
end
