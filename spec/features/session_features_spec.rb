require 'rails_helper'

RSpec.feature User, :type => :feature do
  background do
    @user = create(:user)
    User.find @user.id
  end

  scenario "log in unsuccessful with incorrect credentials" do
    visit '/sessions/new'
    fill_in 'Email', :with => " "
    fill_in 'Password', :with => " "
    click_button 'Log in'
    expect(page).to have_text "Invalid email/password combination"
  end

  scenario "log in successful with correct credentials" do
    visit '/sessions/new'
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => @user.password
    click_button 'Log in'
    expect(page).to have_text "Successfully logged in"
  end

# Attempting to test proper responses with two user session in
# different windows. Does not currently test as intended
  scenario "log out successful", :js => true do
    first_window = page.driver.open_new_window

    within_window first_window do
      visit '/sessions/new'
      fill_in 'Email', :with => @user.email
      fill_in 'Password', :with => @user.password
      click_button 'Log in'
      expect(page).to have_text "Successfully logged in"
    end

    second_window = page.driver.open_new_window

    within_window second_window do
      visit user_path(@user.id)
      expect(page).to have_text @user.email
      click_link 'Log out'
      expect(page).to have_text "Successfully logged out"
    end

    within_window first_window do
      click_link 'Log out'
    end
  end

# Still need to finish the following tests. Doesn't currently work.
  scenario "log in is remembered", :js => true do
    include SessionsHelper
    # current_window = page.driver.current_window

    visit '/sessions/new'
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => @user.password
    check 'Remember me on this computer'
    click_button 'Log in'
    javascript:window.close()
    visit '/'
    expect(page).to have_button "Log out"

    # log_in_as(@user, remember_me: '1')
    # expect(cookies['remember_token']).to_not eq nil
  end

  scenario "log in is not remembered" do
    log_in_as(@user, remember_me: '0')
    expect(cookies['remember_token']).to eq nil
  end
end
