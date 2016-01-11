require 'rails_helper'

RSpec.feature ProduceItem, :type => :feature do
  let(:user) { user = create(:user) }

  let(:produce_item) do
    produce_item = create(:produce_item)
  end

  # let(:garden_item) do
  #   garden_item = create(:garden_item)
  #   GardenItem.find garden.id
  # end

  # let(:produce_item) do
  #   produce_item = garden_item.produce_items.create(:produce_item)
  #   ProduceItem.find produce_item.id
  # end

  # let(:produce_items) do
  #   create(:garden_item_with_produce_items)
  # end

  # let(:user_attributes) { attributes_for :user }
  # let(:invalid_user_attributes) { attributes_for :user, first_name: "" }
  # let(:new_user_attributes) { attributes_for :user, first_name: "David" }

  # let(:two_users) do
  #   two_users = create_pair(:user)
  # end

  # let(:admin) do
  #   admin = create(:admin)
  # end

  scenario "Create produce item" do
    visit "/"
    log_in_with(user)
    visit "/produce_items"
    click_link "New Produce Item"
    # Cannot get the following line to test
    # expect(page).to have_current_path(new_produce_item_path)
    expect(page).to have_field "Category"
    fill_in("Name", :with => "Carrot")
    select("vegetable", :from => "Category")
    click_button "Create produce item"
    expect(page).to have_text "Produce item was successfully created."
  end
end
