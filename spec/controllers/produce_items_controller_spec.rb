require 'rails_helper'

RSpec.describe ProduceItemsController, :type => :controller do
  let(:user) { user = create(:user) }
  let(:produce_item) { produce_item = create(:produce_item) }
  let(:produce_items) { produce_items = create_list(:produce_item, 5) }

  let(:valid_attributes) { attributes_for :produce_item }

  let(:invalid_attributes) { attributes_for :produce_item, name: "" }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ProduceItemsController. Be sure to keep this updated too.

  # let(:valid_session) { {} }

  context "when logged in" do
    before(:each) do
      login user
    end

    describe "GET #index" do
      it "loads the page successfully" do
        get :index
        expect(response).to be_success
      end

      it "assigns all produce_items as @produce_items" do
        get :index
        expect(assigns(:produce_items)).to eq(produce_items)
      end
    end

    describe "GET #show" do
      it "loads the page successfully" do
        get :show, id: produce_item.id
        expect(response).to be_success
      end

      it "assigns the requested produce_item as @produce_item" do
        get :show, id: produce_item.to_param
        expect(assigns(:produce_item)).to eq(produce_item)
      end
    end

    describe "GET new" do
      it "assigns a new produce_item as @produce_item" do
        get :new
        expect(assigns(:produce_item)).to be_a_new(ProduceItem)
      end
    end

    describe "GET edit" do
      it "assigns the requested produce_item as @produce_item" do
        get :edit, id: produce_item.to_param
        expect(assigns(:produce_item)).to eq(produce_item)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new ProduceItem" do
          expect {
            post :create, produce_item: valid_attributes
          }.to change(ProduceItem, :count).by(1)
        end

        it "assigns a newly created produce_item as @produce_item" do
          post :create, produce_item: valid_attributes
          expect(assigns(:produce_item)).to be_a(ProduceItem)
          expect(assigns(:produce_item)).to be_persisted
        end

        it "redirects to the list of produce_items" do
          post :create, produce_item: valid_attributes
          expect(response).to redirect_to produce_items_path
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved produce_item as @produce_item" do
          post :create, produce_item: invalid_attributes
          expect(assigns(:produce_item)).to be_a_new(ProduceItem)
        end

        it "re-renders the 'new' template" do
          post :create, produce_item: invalid_attributes
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        let(:new_attributes) { { name: "banana", category: "Fruit" } }

        it "updates the requested produce_item" do
          produce_item = ProduceItem.create! valid_attributes
          put :update, id: produce_item.to_param, produce_item: new_attributes
          expect {
            produce_item.reload
          }.to change(produce_item, :category).from("Vegetable").to("Fruit")
        end

        it "assigns the requested produce_item as @produce_item" do
          produce_item = ProduceItem.create! valid_attributes
          put :update, id: produce_item.to_param, produce_item: new_attributes
          expect(assigns(:produce_item)).to eq(produce_item)
        end

        it "redirects to the list of produce_items" do
          produce_item = ProduceItem.create! valid_attributes
          put :update, id: produce_item.to_param, produce_item: new_attributes
          expect(response).to redirect_to produce_items_path
        end
      end

      describe "with invalid params" do
        it "assigns the produce_item as @produce_item" do
          produce_item = ProduceItem.create! valid_attributes
          put :update, id: produce_item.to_param, produce_item: invalid_attributes
          expect(assigns(:produce_item)).to eq(produce_item)
        end

        it "re-renders the 'edit' template" do
          produce_item = ProduceItem.create! valid_attributes
          put :update, id: produce_item.to_param, produce_item: invalid_attributes
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested produce_item" do
        produce_item = ProduceItem.create! valid_attributes
        expect {
          delete :destroy, id: produce_item.to_param
        }.to change(ProduceItem, :count).by(-1)
      end

      it "redirects to the produce_items list" do
        produce_item = ProduceItem.create! valid_attributes
        delete :destroy, id: produce_item.to_param
        expect(response).to redirect_to(produce_items_path)
      end
    end
  end

  context "when not logged in" do
    it "redirects index to login form" do
      get :index
      expect(response).to redirect_to login_path
    end

    it "redirects show to login form" do
      get :show, id: produce_item.id
      expect(response).to redirect_to login_path
    end

    it "redirects new to login form" do
      get :new
      expect(response).to redirect_to login_path
    end

    it "redirects edit to login form" do
      get :edit, id: produce_item.id
      expect(response).to redirect_to login_path
    end

    it "redirects create to login form" do
      get :create, id: produce_item.id
      expect(response).to redirect_to login_path
    end

    it "redirects update to login form" do
      get :update, id: produce_item.id
      expect(response).to redirect_to login_path
    end

    it "redirects destroy to login form" do
      get :destroy, id: produce_item.id
      expect(response).to redirect_to login_path
    end
  end
end
