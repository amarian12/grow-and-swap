require 'rails_helper'

RSpec.feature User, :type => :feature do
  given(:user) { user = create(:user) }
  given(:admin) { admin = create(:admin) }

  given!(:users) { users = create_list(:user, 5) }

  given!(:garden_item) do
    garden_item = create(:garden_item)
  end

  background do
    log_in_with(user)
  end

  feature "User garden items" do
    scenario "User can view another user's garden items" do
      visit "/users"
      click_link "#{users.first.full_name}"
      expect(page).to have_text "garden items"
    end
  end
end
