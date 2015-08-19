require 'rails_helper'

RSpec.feature User, :type => :feature do
  background do
    @user = create(:user)
    User.find @user.id
  end

  scenario "log in unsuccessful with invalid information" do
    visit '/sessions/new'
    fill_in 'Email', :with => " "
    fill_in 'Password', :with => " "
    click_button 'Log in'
    expect(page).to have_text "Invalid email/password combination"
    # Should the next two lines be in their own test?
    visit '/'
    expect(page).to_not have_text "Invalid email/password combination"
  end

  scenario "log in successful with correct credentials" do
    visit '/sessions/new'
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => @user.password
    click_button 'Log in'
    expect(page).to have_text "Successfully logged in"
  end

  scenario "log out successful" do
    visit '/sessions/new'
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => @user.password
    click_button 'Log in'
    expect(page).to have_text "Successfully logged in"
    click_link 'Log out'
    expect(page).to have_text "Successfully logged out"
  end
end
