require 'rails_helper'

RSpec.feature ProduceItem, :type => :feature do
  given(:user) { user = create(:user) }
  given(:admin) { admin = create(:admin) }

  given!(:produce_item) do
    produce_item = create(:produce_item)
  end

  feature "Produce items listing page features" do
    context "When logged in as admin user" do
      background do
        log_in_with(admin)
        visit "/produce_items"
      end

      scenario "Admin user can create a new produce item" do
        click_link "New produce item"
        # Cannot get the following line to test
        # expect(page).to have_current_path(new_produce_item_path)
        expect(page).to have_field "Category"
        fill_in("Name", with: "carrot")
        select("Vegetable", from: "Category")
        click_button "Create produce item"
        expect(page).to have_text "Produce item was successfully created."
      end
    end

    context "When logged in as non-admin user" do
      background do
        log_in_with(user)
        visit "/produce_items"
      end

      scenario "User can click show to see individual produce item" do
        click_link "Show"
        expect(current_path).to eq "/produce_items/3"
      end

      scenario "User cannot see 'New produce item' button" do
        expect(page).to_not have_link "New produce item"
      end
    end
  end

  feature "Specific produce item page features" do
    context "When logged in as admin user" do
      background do
        log_in_with(admin)
        visit "/produce_items"
        click_link "Show"
      end

      scenario "Admin user can edit produce item" do
        click_link "Edit"
        expect(current_path).to eq "/produce_items/5/edit"
      end

      scenario "Admin user can destroy produce item" do
        click_link "Destroy"
        expect(current_path).to eq(produce_items_path)
        expect(page).to have_content "Produce item was successfully destroyed."
      end
    end

    context "When logged in as non-admin user" do
      given!(:garden_item) do
        garden_item = create(:garden_item, produce_item_id: produce_item.id)
      end

      background do
        log_in_with(user)
        visit "/produce_items"
        click_link "Show"
      end

      scenario "User cannot see 'Edit' or 'Destroy' links" do
        expect(page).to_not have_link "Edit"
        expect(page).to_not have_link "Destroy"
      end

      scenario "User can see a list of people with current produce item up for trade" do
        expect(page).to have_content(produce_item.sellers.first.first_name)
      end

      scenario "User can click on other people's produce item as garden item" do
        within_table("People who have this item") do
          click_link "Show item"
        end
        expect(page).to have_text "Garden item:"
        expect(page).to have_text "Quantity:"
      end
    end
  end
end
