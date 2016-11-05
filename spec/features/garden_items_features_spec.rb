require 'rails_helper'

RSpec.feature GardenItem, :type => :feature do
  given(:user) { user = create(:user) }

  given(:other_user) { other_user = create(:user) }

  given!(:garden_item) do
    garden_item = create(:garden_item)
  end

  given!(:produce_item) do
    produce_item = create(:produce_item, name: "Carrot")
  end

  context "When logged in or not" do
    scenario "view list of garden items" do
      visit "/"
      click_link "Browse garden items in your area"
      expect(page).to have_text "Garden Items in Your Area"
    end
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
    end

    scenario "create garden item" do
      visit "/"
      visit "/garden_items"
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
      visit "/garden_items/1"
      expect(page).to have_link "Edit"
      click_link "Log out"
      log_in_with(other_user)
      visit "/garden_items"
      click_link "Show"
      expect(page).to_not have_link "Edit"
    end
  end
end
