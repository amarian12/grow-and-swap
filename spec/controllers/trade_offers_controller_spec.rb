require 'rails_helper'

RSpec.describe TradeOffersController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # TradeOffer. As you add validations to TradeOffer, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TradeOffersController. Be sure to keep this updated too.
  # let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all trade_offers as @trade_offers" do
      trade_offer = TradeOffer.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:trade_offers)).to eq([trade_offer])
    end
  end

  describe "GET show" do
    it "assigns the requested trade_offer as @trade_offer" do
      trade_offer = TradeOffer.create! valid_attributes
      get :show, {:id => trade_offer.to_param}, valid_session
      expect(assigns(:trade_offer)).to eq(trade_offer)
    end
  end

  describe "GET new" do
    it "assigns a new trade_offer as @trade_offer" do
      get :new, {}, valid_session
      expect(assigns(:trade_offer)).to be_a_new(TradeOffer)
    end
  end

  describe "GET edit" do
    it "assigns the requested trade_offer as @trade_offer" do
      trade_offer = TradeOffer.create! valid_attributes
      get :edit, {:id => trade_offer.to_param}, valid_session
      expect(assigns(:trade_offer)).to eq(trade_offer)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new TradeOffer" do
        expect {
          post :create, {:trade_offer => valid_attributes}, valid_session
        }.to change(TradeOffer, :count).by(1)
      end

      it "assigns a newly created trade_offer as @trade_offer" do
        post :create, {:trade_offer => valid_attributes}, valid_session
        expect(assigns(:trade_offer)).to be_a(TradeOffer)
        expect(assigns(:trade_offer)).to be_persisted
      end

      it "redirects to the created trade_offer" do
        post :create, {:trade_offer => valid_attributes}, valid_session
        expect(response).to redirect_to(TradeOffer.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved trade_offer as @trade_offer" do
        post :create, {:trade_offer => invalid_attributes}, valid_session
        expect(assigns(:trade_offer)).to be_a_new(TradeOffer)
      end

      it "re-renders the 'new' template" do
        post :create, {:trade_offer => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested trade_offer" do
        trade_offer = TradeOffer.create! valid_attributes
        put :update, {:id => trade_offer.to_param, :trade_offer => new_attributes}, valid_session
        trade_offer.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested trade_offer as @trade_offer" do
        trade_offer = TradeOffer.create! valid_attributes
        put :update, {:id => trade_offer.to_param, :trade_offer => valid_attributes}, valid_session
        expect(assigns(:trade_offer)).to eq(trade_offer)
      end

      it "redirects to the trade_offer" do
        trade_offer = TradeOffer.create! valid_attributes
        put :update, {:id => trade_offer.to_param, :trade_offer => valid_attributes}, valid_session
        expect(response).to redirect_to(trade_offer)
      end
    end

    describe "with invalid params" do
      it "assigns the trade_offer as @trade_offer" do
        trade_offer = TradeOffer.create! valid_attributes
        put :update, {:id => trade_offer.to_param, :trade_offer => invalid_attributes}, valid_session
        expect(assigns(:trade_offer)).to eq(trade_offer)
      end

      it "re-renders the 'edit' template" do
        trade_offer = TradeOffer.create! valid_attributes
        put :update, {:id => trade_offer.to_param, :trade_offer => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested trade_offer" do
      trade_offer = TradeOffer.create! valid_attributes
      expect {
        delete :destroy, {:id => trade_offer.to_param}, valid_session
      }.to change(TradeOffer, :count).by(-1)
    end

    it "redirects to the trade_offers list" do
      trade_offer = TradeOffer.create! valid_attributes
      delete :destroy, {:id => trade_offer.to_param}, valid_session
      expect(response).to redirect_to(trade_offers_url)
    end
  end

end
