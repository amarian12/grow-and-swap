require 'rails_helper'

RSpec.describe "users/show", :type => :view do
  before(:each) do
    user = assign(:user, User.create!())
  end

  before(:each) do
    @user = create(:user)
    User.find @user.id
  end

  let(:user) do
    user = create(:user)
    User.find user.id
  end

  it "renders attributes in <p>" do
    render
  end
end
