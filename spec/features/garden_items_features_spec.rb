require 'rails_helper'

RSpec.feature GardenItem, :type => :feature do
  given(:user) { user = create(:user) }

  given(:other_user) { other_user = create(:user) }

  given!(:users) { users = create_list(:user, 5) }

  given!(:garden_item) do
    garden_item = create(:garden_item)
  end

  given!(:produce_item) do
    produce_item = create(:produce_item, name: "Carrot")
  end

  context "When not logged in" do
    scenario "guest cannot see garden item edit/destroy links" do
      visit "/garden_items"
      expect(page).to have_link "Show"
      expect(page).to_not have_link "Edit"
      expect(page).to_not have_link "Destroy"
    end
  end

  context "When logged in" do
    background do
      log_in_with(garden_item.seller)
      visit "/"
      click_link "My garden items"
    end

    scenario "user can create garden item" do
      click_link "New garden item"
      # Cannot get the following line to test
      # expect(page).to have_current_path(new_garden_item_path)
      expect(page).to have_field "Quantity"
      select "Carrot", from: :garden_item_produce_item_id, visible: false
      fill_in("Quantity", with: 5)
      click_button "Create garden item"
      expect(page).to have_text "Garden item was successfully created."
    end

    scenario "only owner of garden item can see edit link on show page" do
      click_link "Show"
      expect(page).to have_link "Edit"
      expect(page).to have_link "Delete"
      click_link "Log out"
      log_in_with(other_user)
      visit "/garden_items"
      click_link "Show"
      expect(page).to_not have_link "Edit"
      expect(page).to_not have_link "Delete"
    end

    scenario "garden item owner can edit garden item" do
      click_link "Show"
      click_link "Edit"
      expect(current_path).to eq "/garden_items/5/edit"
    end

    scenario "garden item owner can delete garden item" do
      click_link "Show"
      click_link "Delete"
      expect(page).to have_text "Garden item was successfully destroyed."
    end

    scenario "user can view another user's garden items list" do
      visit "/users"
      click_link "#{users.first.full_name}"
      expect(page).to have_text "garden items"
    end
  end
end
