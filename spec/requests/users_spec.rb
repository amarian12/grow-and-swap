require 'rails_helper'

RSpec.describe "Users", :type => :request do
  describe "GET /users" do
    let(:user) { user = create(:user) }

    let(:users) do
      users = create_list(:user, 5)
      User.find user.id
    end

    it "requests users list" do
      login(user)
      get users_path
      :users
      expect(response.status).to be(200)
    end
  end
end
