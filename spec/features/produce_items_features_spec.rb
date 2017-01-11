require 'rails_helper'

RSpec.feature ProduceItem, :type => :feature do
  given(:user) { user = create(:user) }
  given(:admin) { admin = create(:admin) }

  given!(:produce_item) do
    produce_item = create(:produce_item)
  end

  given!(:cabbage) { cabbage = create(:cabbage) }
  given!(:apple) { apple = create(:apple) }
  given!(:potato) { potato = create(:potato) }

  feature "listing page features" do
    context "when logged in as admin user" do
      background do
        log_in_with(admin)
        visit "/produce_items"
      end

      scenario "admin user can create a new produce item" do
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

    context "when logged in as non-admin user" do
      background do
        log_in_with(user)
        visit "/produce_items"
      end

      scenario "user can click show to see individual produce item" do
        within("table/tbody/tr", text: "Cabbages") do
          click_link "Show"
        end
        expect(page).to have_text "Cabbages"
        expect(page).to have_text "People who have this item"
      end

      scenario "user can search for a produce item" do
        fill_in "search", with: "cabbage"
        click_button "Search produce item"
        within "table/tbody" do
          expect(page).to have_text "Cabbages"
          expect(page).to have_selector("tr", count: 1)
        end
      end

      scenario "user cannot see 'New produce item' button" do
        expect(page).to_not have_link "New produce item"
      end
    end
  end

  feature "specific page features" do
    context "when logged in as admin user" do
      background do
        log_in_with(admin)
        visit "/produce_items"
        within("table/tbody/tr", text: "Cabbages") do
          click_link "Show"
        end
      end

      scenario "admin user can edit produce item" do
        click_link "Edit"
        expect(page).to have_text "Editing Produce Item"
        expect(page).to have_selector("input[value='Cabbages']")
      end

      scenario "admin user can destroy produce item" do
        click_link "Destroy"
        expect(current_path).to eq(produce_items_path)
        expect(page).to have_content "Produce item was successfully destroyed."
      end
    end

    context "when logged in as non-admin user" do
      given!(:garden_item) do
        garden_item = create(:garden_item, produce_item_id: produce_item.id)
      end

      background do
        log_in_with(user)
        visit "/produce_items"
        within("table/tbody/tr", text: "Zucchinis") do
          click_link "Show"
        end
      end

      scenario "user cannot see 'Edit' or 'Destroy' links" do
        expect(page).to_not have_link "Edit"
        expect(page).to_not have_link "Destroy"
      end

      scenario "user can see a list of people with current produce item up for trade" do
        expect(page).to have_content(produce_item.sellers.first.first_name)
      end

      scenario "user can click on other people's produce item as garden item" do
        within_table("People who have this item") do
          click_link "Show item"
        end
        expect(page).to have_text "Garden item:"
        expect(page).to have_text "Quantity:"
      end
    end
  end
end
