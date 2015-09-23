require 'rails_helper'

RSpec.describe "users/index", :type => :view do
  before(:each) do
    @user = create(:user)
    # @user = assign(:user, User.create!())
    @user = assign(:user, User.find(@user.id))
    # User.find @user.id
  end

  # it "renders a list of users" do
  #   p :users
  #   render
  # end
end
