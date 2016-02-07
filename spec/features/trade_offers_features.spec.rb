require 'rails_helper'
require 'pry'

RSpec.feature TradeOffer, :type => :feature do
  given(:user) { user = create(:user) }

  # given(:trade_offer) do
  #   trade_offer = create(:trade_offer)
  # end

  feature "User can create trade offer" do
    scenario "Show list of buyer's trade offers" do
      log_in_with(user)
      visit root_path
      click_link "My trade offers"
      expect(page).to have_text("Outstanding trade offers")
    end

    scenario "Show buyer's trade offer" do

    end

    scenario "Create trade offer" do

    end

    scenario "Edit trade offer" do

    end

    scenario "Delete trade offer" do

    end
  end

  feature "Accepting/rejecting offer" do
    scenario "Accept trade offer" do

    end

    scenario "Reject trade offer" do

    end
  end
end
