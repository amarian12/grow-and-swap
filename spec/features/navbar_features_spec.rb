require 'rails_helper'

RSpec.feature "Navbar", :type => :feature do
  background do
    @user = create(:user)
    User.find @user.id
  end

  # scenario "log in unsuccessful with incorrect credentials" do
  #   visit '/sessions/new'
  #   fill_in 'Email', :with => " "
  #   fill_in 'Password', :with => " "
  #   click_button 'Log in'
  #   expect(page).to have_text "Invalid email/password combination"
  # end

  scenario "displays 'Home', 'Sign up', and 'Log in' links while not logged in" do
    visit '/'
    expect(page).to have_link("Home")
    expect(page).to have_link("Log in")
    expect(page).to have_link("Sign up")
  end

  scenario "displays 'Home', and 'Log out' links while logged in" do
    visit '/'
    log_in_with(@user)
    expect(page).to have_link("Home")
    expect(page).to have_link("Log out")
  end
end