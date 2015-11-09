require 'rails_helper'

RSpec.describe ProduceItemsController, :type => :controller do
  let(:user) { user = create(:user) }
  let(:produce_item) { produce_item = create(:produce_item) }
  let(:produce_items) { produce_items = create_list(:produce_item, 5) }
  let(:garden_item) do
    garden_item = create(:produce_item_with_garden_items)
  end

  let(:valid_attributes) { attributes_for :produce_item }

  let(:invalid_attributes) { attributes_for :produce_item, name: "" }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ProduceItemsController. Be sure to keep this updated too.

  # let(:valid_session) { valid_session = log_in user }

  describe "GET #index" do
    before(:each) do
      log_in user
    end

    it "assigns all produce_items as @produce_items" do
      get :index #valid_session
      expect(assigns(:produce_items)).to eq(produce_items)
    end
  end

  describe "GET #show" do
    context "when logged in" do
      before(:each) do
        log_in user
      end

      it "loads the page successfully" do
        get :show, id: produce_item.id
        expect(response).to be_success
      end
    end

    context "when not logged in" do
      it "redirects show to login form" do
        get :show, id: produce_item.id
        expect(response).to redirect_to login_path
      end
    end

    it "assigns the requested produce_item as @produce_item" do
      get :show, {:id => produce_item.to_param}#, valid_session
      expect(assigns(:produce_item)).to eq(produce_item)
    end
  end

  describe "GET new" do
    it "assigns a new produce_item as @produce_item" do
      get :new, {}, valid_session
      expect(assigns(:produce_item)).to be_a_new(ProduceItem)
    end
  end

  describe "GET edit" do
    it "assigns the requested produce_item as @produce_item" do
      produce_item = ProduceItem.create! valid_attributes
      get :edit, {:id => produce_item.to_param}, valid_session
      expect(assigns(:produce_item)).to eq(produce_item)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new ProduceItem" do
        expect {
          post :create, {:produce_item => valid_attributes}, valid_session
        }.to change(ProduceItem, :count).by(1)
      end

      it "assigns a newly created produce_item as @produce_item" do
        post :create, {:produce_item => valid_attributes}, valid_session
        expect(assigns(:produce_item)).to be_a(ProduceItem)
        expect(assigns(:produce_item)).to be_persisted
      end

      it "redirects to the created produce_item" do
        post :create, {:produce_item => valid_attributes}, valid_session
        expect(response).to redirect_to(ProduceItem.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved produce_item as @produce_item" do
        post :create, {:produce_item => invalid_attributes}, valid_session
        expect(assigns(:produce_item)).to be_a_new(ProduceItem)
      end

      it "re-renders the 'new' template" do
        post :create, {:produce_item => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested produce_item" do
        produce_item = ProduceItem.create! valid_attributes
        put :update, {:id => produce_item.to_param, :produce_item => new_attributes}, valid_session
        produce_item.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested produce_item as @produce_item" do
        produce_item = ProduceItem.create! valid_attributes
        put :update, {:id => produce_item.to_param, :produce_item => valid_attributes}, valid_session
        expect(assigns(:produce_item)).to eq(produce_item)
      end

      it "redirects to the produce_item" do
        produce_item = ProduceItem.create! valid_attributes
        put :update, {:id => produce_item.to_param, :produce_item => valid_attributes}, valid_session
        expect(response).to redirect_to(produce_item)
      end
    end

    describe "with invalid params" do
      it "assigns the produce_item as @produce_item" do
        produce_item = ProduceItem.create! valid_attributes
        put :update, {:id => produce_item.to_param, :produce_item => invalid_attributes}, valid_session
        expect(assigns(:produce_item)).to eq(produce_item)
      end

      it "re-renders the 'edit' template" do
        produce_item = ProduceItem.create! valid_attributes
        put :update, {:id => produce_item.to_param, :produce_item => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested produce_item" do
      produce_item = ProduceItem.create! valid_attributes
      expect {
        delete :destroy, {:id => produce_item.to_param}, valid_session
      }.to change(ProduceItem, :count).by(-1)
    end

    it "redirects to the produce_items list" do
      produce_item = ProduceItem.create! valid_attributes
      delete :destroy, {:id => produce_item.to_param}, valid_session
      expect(response).to redirect_to(produce_items_url)
    end
  end

end
