require 'rails_helper'

RSpec.describe GardenItemsController, :type => :controller do
  let(:user) { user = create(:user) }

  let(:garden_item) do
    garden_item = create(:garden_item)
  end

  let!(:produce_item) do
    produce_item = create(:produce_item)
  end

  # This should return the minimal set of attributes required to create a valid
  # Garden_item. As you add validations to Garden_item, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { attributes_for :garden_item }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Garden_itemsController. Be sure to keep this updated too.
  # let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all garden_items as @garden_items" do
      garden_item = GardenItem.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:garden_items)).to eq([garden_item])
    end
  end

  describe "GET show" do
    it "assigns the requested garden_item as @garden_item" do
      garden_item = GardenItem.create! valid_attributes
      get :show, {:id => garden_item.to_param}, valid_session
      expect(assigns(:garden_item)).to eq(garden_item)
    end
  end

  describe "GET new" do
    it "assigns a new garden_item as @garden_item" do
      get :new, {}, valid_session
      expect(assigns(:garden_item)).to be_a_new(GardenItem)
    end
  end

  describe "GET edit" do
    it "assigns the requested garden_item as @garden_item" do
      garden_item = GardenItem.create! valid_attributes
      get :edit, {:id => garden_item.to_param}, valid_session
      expect(assigns(:garden_item)).to eq(garden_item)
    end
  end

  describe "POST create" do
    before(:each) do
      log_in user
    end

    describe "with valid params" do
      it "creates a new garden_item" do
        expect {
          post :create, {:garden_item => valid_attributes}
        }.to change(GardenItem, :count).by(1)
      end

      it "assigns a newly created garden_item as @garden_item" do
        post :create, {:garden_item => valid_attributes}, valid_session
        expect(assigns(:garden_item)).to be_a(GardenItem)
        expect(assigns(:garden_item)).to be_persisted
      end

      it "redirects to the created garden_item" do
        post :create, {:garden_item => valid_attributes}, valid_session
        expect(response).to redirect_to(GardenItem.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved garden_item as @garden_item" do
        post :create, {:garden_item => invalid_attributes}, valid_session
        expect(assigns(:garden_item)).to be_a_new(GardenItem)
      end

      it "re-renders the 'new' template" do
        post :create, {:garden_item => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested garden_item" do
        garden_item = GardenItem.create! valid_attributes
        put :update, {:id => garden_item.to_param, :garden_item => new_attributes}, valid_session
        garden_item.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested garden_item as @garden_item" do
        garden_item = GardenItem.create! valid_attributes
        put :update, {:id => garden_item.to_param, :garden_item => valid_attributes}, valid_session
        expect(assigns(:garden_item)).to eq(garden_item)
      end

      it "redirects to the garden_item" do
        garden_item = GardenItem.create! valid_attributes
        put :update, {:id => garden_item.to_param, :garden_item => valid_attributes}, valid_session
        expect(response).to redirect_to(garden_item)
      end
    end

    describe "with invalid params" do
      it "assigns the garden_item as @garden_item" do
        garden_item = GardenItem.create! valid_attributes
        put :update, {:id => garden_item.to_param, :garden_item => invalid_attributes}, valid_session
        expect(assigns(:garden_item)).to eq(garden_item)
      end

      it "re-renders the 'edit' template" do
        garden_item = GardenItem.create! valid_attributes
        put :update, {:id => garden_item.to_param, :garden_item => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested garden_item" do
      garden_item = GardenItem.create! valid_attributes
      expect {
        delete :destroy, {:id => garden_item.to_param}, valid_session
      }.to change(Garden_item, :count).by(-1)
    end

    it "redirects to the garden_items list" do
      garden_item = GardenItem.create! valid_attributes
      delete :destroy, {:id => garden_item.to_param}, valid_session
      expect(response).to redirect_to(garden_items_url)
    end
  end

end
