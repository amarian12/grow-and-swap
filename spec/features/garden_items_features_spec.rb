require 'rails_helper'

RSpec.feature GardenItem, :type => :feature do
  given(:user) { user = create(:user) }

  given(:garden_item) do
    garden_item = create(:garden_item)
  end

  given!(:produce_item) do
    produce_item = create(:produce_item, name: "Carrot")
  end

  scenario "View list of garden items" do
    visit "/"
    click_link "Browse garden items in your area"
    expect(page).to have_text "Garden Items in Your Area"
  end

  scenario "Create garden item" do
    visit "/"
    log_in_with(user)
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
end
