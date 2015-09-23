require 'rails_helper'

RSpec.describe "users/edit", :type => :view do
  before(:each) do
    @user = create(:user)
    # @user = assign(:user, User.create!())
    @user = assign(:user, User.find(@user.id))
    # User.find @user.id
  end

# I believe the next rails generated test is for CSS stylesheets

  # it "renders the edit user form" do
  #   render

  #   assert_select "form[action=?][method=?]", edit_user_path(@user), "post" do
  #   end
  # end
end
