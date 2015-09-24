require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  let(:user) do
    user = create(:user)
  end

  let(:user_attributes) { attributes_for :user }
  let(:invalid_user_attributes) { attributes_for :user, first_name: "" }
  let(:new_user_attributes) { attributes_for :user, first_name: "David" }

  describe "GET #index" do
    it "loads the page successfully" do
      get :index
      expect(response).to be_success
    end

    context "when not logged in" do
      it "redirects index to login form" do
        get :index
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "GET #show" do
    it "assigns the user" do
      get :show, id: user.id
      expect(assigns(:user)).to be_a(User)
    end

    it "loads the page successfully" do
      get :show, id: user.id
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    it "assigns the user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "loads the page successfully" do
      get :new
      expect(response).to be_success
    end

    it "renders the new user template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "assigns the user" do
        post :create, user: user_attributes
        expect(assigns(:user)).to be_a(User)
      end

      it "loads the page successfully" do
        post :create, user: user_attributes
        expect(response.status).to eq 302
      end

      it "creates a user" do
        expect {
          post :create, user: user_attributes
          }.to change(User, :count).by(1)
      end

      it "redirects to user home page" do
        binding.pry
        post :create, user: user_attributes
        binding.pry
        expect(response).to redirect_to user_path(user)
      end
    end

    context "with invalid params" do
      it "creates a user" do
        expect {
          post :create, user: invalid_user_attributes
          }.to change(User, :count).by(0)
      end

      it "renders the new user form" do
        post :create, user: invalid_user_attributes
        expect(response).to redirect_to new_user_path
      end
    end
  end

  describe "GET #edit" do
    it "assigns the user" do
      get :edit, id: user.id
      expect(assigns(:user)).to be_a(User)
    end

    it "loads the page successfully" do
      get :edit, id: user.id
      expect(response).to be_success
    end

    it "renders the edit user form" do
      get :edit, id: user.id
      expect(response).to render_template(:edit)
    end

    context "when not logged in" do
      it "redirects edit to login form" do
        get :edit, id: user.id
        expect(response).to redirect_to login_path
      end
    end

    context "when logged in as wrong user" do
      it "redirects edit to root path" do
        # See page 398 of ruby on rails tutorial for example on how to correctly implement this
        log_in_as(@other_user)
        get :edit, id: user.id
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      it "assigns the user" do
        patch :update, id: user.id, user: user_attributes
        expect(assigns(:user)).to be_a(User)
      end

      it "changes one or more user attributes" do
        patch :update, id: user.id, user: new_user_attributes
        user.reload
        expect(user.first_name).to eq("David")
      end

      it "loads the page successfully" do
        patch :update, id: user.id, user: user_attributes
        expect(response.status).to eq 302
      end

      it "redirects to user home page" do
        patch :update, id: user.id, user: user_attributes
        expect(response).to redirect_to user_path(user)
      end
    end

    context "with invalid params" do
      it "renders the edit user form" do
        patch :update, id: user.id, user: invalid_user_attributes
        expect(response).to redirect_to edit_user_path(user)
      end
    end

    context "when not logged in" do
      it "redirects update to login form" do
        patch :update, id: user.id, user: user_attributes
        expect(response).to redirect_to login_path
      end
    end

    context "when logged in as wrong user" do
      it "redirects update to root path" do
        # See page 398 of ruby on rails tutorial for example on how to correctly implement this
        log_in_as(@other_user)
        patch :update, id: user.id
        expect(response).to redirect_to root_path
      end
    end
  end

# Implement user destroy action tests only with admin user functionality

  # describe "DELETE #destroy" do
  #   it "assigns the user" do
  #     delete :destroy, id: user.id
  #     expect(assigns(:user)).to be_a(user)
  #   end

  #   it "loads the page successfully" do
  #     delete :destroy, id: user.id
  #     expect(response).to be_success
  #   end
  # end
end
