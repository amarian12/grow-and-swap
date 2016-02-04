require 'rails_helper'

RSpec.describe GardenItemsController, :type => :controller do
  let(:garden_item) do
    garden_item = create(:garden_item)
  end

  let(:garden_items) do
    garden_items = create_list(:garden_item, 5)
  end

  # This should return the minimal set of attributes required to create a valid
  # Garden_item. As you add validations to Garden_item, be sure to
  # adjust the attributes here as well.

  # I initially used #attributes_for on :garden_item but it didn't work and caused me several days
  #   of head-scratching to figure out. Stay away from in the future.
  let(:valid_attributes) { {
    quantity: 9,
    user_id: garden_item.user.id,
    produce_item_id: garden_item.produce_item.id
  } }

  let(:invalid_attributes) { {
    quantity: "",
    user_id: garden_item.user.id,
    produce_item_id: garden_item.produce_item.id
  } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Garden_itemsController. Be sure to keep this updated too.
  # let(:valid_session) { {} }

  describe "GET index" do
    it "loads the page successfully" do
      get :index
      expect(response).to be_success
    end

    it "assigns all garden_items as @garden_items" do
      get :index
      expect(assigns(:garden_items)).to eq(garden_items)
    end
  end

  describe "GET show" do
    it "loads the page successfully" do
      get :show, id: garden_item.to_param
      expect(response).to be_success
    end

    it "assigns the requested garden_item as @garden_item" do
      get :show, id: garden_item.to_param
      expect(assigns(:garden_item)).to eq(garden_item)
    end
  end

  describe "GET new" do
    context "when logged in" do
      it "assigns a new garden_item as @garden_item" do
        login(garden_item.user)
        get :new
        expect(assigns(:garden_item)).to be_a_new(GardenItem)
      end
    end

    context "when not logged in" do
      it "redirects new to login form" do
        get :new
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "GET edit" do
    context "when logged in" do
      it "assigns the requested garden_item as @garden_item" do
        login(garden_item.user)
        get :edit, id: garden_item.to_param
        expect(assigns(:garden_item)).to eq(garden_item)
      end
    end

    context "when not logged in" do
      it "redirects edit to login form" do
        get :edit, id: garden_item.to_param
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "POST create" do
    context "when logged in" do
      before(:each) do
        login(garden_item.user)
      end

      context "with valid params" do
        it "creates a new garden_item" do
          expect {
            post :create, garden_item: valid_attributes
          }.to change(GardenItem, :count).by(1)
        end

        it "assigns a newly created garden_item as @garden_item" do
          post :create, garden_item: valid_attributes
          expect(assigns(:garden_item)).to be_a(GardenItem)
          expect(assigns(:garden_item)).to be_persisted
        end

        it "redirects to the created garden_item" do
          post :create, garden_item: valid_attributes
          expect(response).to redirect_to(GardenItem.last)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved garden_item as @garden_item" do
          post :create, garden_item: invalid_attributes
          expect(assigns(:garden_item)).to be_a_new(GardenItem)
        end

        it "re-renders the 'new' template" do
          post :create, garden_item: invalid_attributes
          expect(response).to render_template("new")
        end
      end
    end

    context "when not logged in" do
      it "redirects create to login form" do
        post :create
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "PUT update" do
    context "when logged in" do
      before(:each) do
        login(garden_item.user)
      end

      context "with valid params" do
        let(:new_attributes) { {
          quantity: 31,
          user_id: garden_item.user.id,
          produce_item_id: garden_item.produce_item.id
        } }

        it "updates the requested garden_item" do
          put :update, id: garden_item.to_param, garden_item: new_attributes
        end

        it "assigns the requested garden_item as @garden_item" do
          put :update, id: garden_item.to_param, garden_item: new_attributes
          expect(assigns(:garden_item)).to eq(garden_item)
        end

        it "redirects to the garden_item" do
          put :update, id: garden_item.to_param, garden_item: new_attributes
          expect(response).to redirect_to(garden_item)
        end
      end

      context "with invalid params" do
        it "assigns the garden_item as @garden_item" do
          put :update, id: garden_item.to_param, garden_item: invalid_attributes
          expect(assigns(:garden_item)).to eq(garden_item)
        end

        it "re-renders the 'edit' template" do
          put :update, id: garden_item.to_param, garden_item: invalid_attributes
          expect(response).to render_template("edit")
        end
      end
    end

    context "when not logged in" do
      it "redirects update to login form" do
        put :update, id: garden_item.to_param, garden_item: valid_attributes
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "DELETE destroy" do
    context "when logged in" do
      before(:each) do
        login(garden_item.user)
      end

      it "destroys the requested garden_item" do
        expect {
          delete :destroy, id: garden_item.to_param
        }.to change(GardenItem, :count).by(-1)
      end

      it "redirects to the garden_items list" do
        delete :destroy, id: garden_item.to_param
        expect(response).to redirect_to(garden_items_path)
      end
    end

    context "when not logged in" do
      it "redirects destroy to login form" do
        delete :destroy, id: garden_item.to_param
        expect(response).to redirect_to login_path
      end
    end
  end
end
