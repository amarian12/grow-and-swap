require 'rails_helper'

RSpec.describe TradeOffersController, :type => :controller do
  let(:trade_offer) do
    trade_offer = create(:trade_offer)
  end

  let(:initial_trade_offer) do
    initial_trade_offer = create(:initial_trade_offer)
  end

  let(:trade_offers) do
    trade_offers = create_list(:trade_offer, 5)
  end

  # This should return the minimal set of attributes required to create a valid
  # TradeOffer. As you add validations to TradeOffer, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {
    quantity: 8,
    user_id: trade_offer.buyer.id,
    garden_item_id: trade_offer.garden_item.id
  } }

  let(:invalid_attributes) { {
    quantity: "",
    user_id: trade_offer.buyer.id,
    garden_item_id: trade_offer.garden_item.id
  } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TradeOffersController. Be sure to keep this updated too.
  # let(:valid_session) { {} }

  context "when not logged in" do
    describe "GET index" do
      it "redirects new to login form" do
        get :index
        expect(response).to redirect_to login_path
      end
    end

    describe "GET show" do
      it "redirects new to login form" do
        get :show, id: initial_trade_offer.to_param
        expect(response).to redirect_to login_path
      end
    end
  end

  context "when logged in" do
    describe "GET index" do
      before(:each) do
        login(trade_offer.buyer)
      end

      it "loads the page successfully" do
        login(trade_offer.buyer)
        get :index
        expect(response).to be_success
      end

      it "assigns all trade_offers as @trade_offers" do
        # login(trade_offers.first.buyer)
        # binding.pry
        login(trade_offer.buyer)
        get :index
        expect(assigns(:trade_offers)).to eq(trade_offers)
      end
    end

    describe "GET show" do
      before(:each) do
        login(trade_offer.buyer)
      end

      it "assigns the requested trade_offer as @trade_offer" do
        get :show, id: trade_offer.to_param
        expect(assigns(:trade_offer)).to eq(trade_offer)
      end
    end

    describe "GET new" do
      # before(:each) do
      #   login(trade_offer.buyer)
      # end

      # before(:each) do
      #   trade_offer.garden_item_id
      # end

      it "finds the garden_item by id given by params" do
        # binding.pry
        get :new, { trade_offer: { garden_item_id: trade_offer.garden_item_id.to_param }}
        expect(GardenItem).to receive(:find).with(1)
      end

      it "assigns a new trade_offer as @trade_offer" do
        garden_item = double()
        get :new
        expect(assigns(:trade_offer)).to be_a_new(TradeOffer)
      end
    end

    describe "GET edit" do
      before(:each) do
        login(trade_offer.buyer)
      end

      it "assigns the requested trade_offer as @trade_offer" do
        get :edit, id: trade_offer.to_param
        expect(assigns(:trade_offer)).to eq(trade_offer)
      end
    end

    describe "POST create" do
      before(:each) do
        login(trade_offer.buyer)
      end

      context "with valid params" do
        it "creates a new TradeOffer" do
          expect {
            post :create, trade_offer: valid_attributes
          }.to change(TradeOffer, :count).by(1)
        end

        it "assigns a newly created trade_offer as @trade_offer" do
          post :create, trade_offer: valid_attributes
          expect(assigns(:trade_offer)).to be_a(TradeOffer)
          expect(assigns(:trade_offer)).to be_persisted
        end

        it "redirects to the created trade_offer" do
          post :create, trade_offer: valid_attributes
          expect(response).to redirect_to(TradeOffer.last)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved trade_offer as @trade_offer" do
          post :create, trade_offer: invalid_attributes
          expect(assigns(:trade_offer)).to be_a_new(TradeOffer)
        end

        it "re-renders the 'new' template" do
          post :create, trade_offer: invalid_attributes
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT update" do
      before(:each) do
        login(trade_offer.buyer)
      end

      describe "with valid params" do
        let(:new_attributes) { {
          quantity: 13,
          accepted: true,
          user_id: trade_offer.buyer.id,
          garden_item_id: trade_offer.garden_item.id
        } }

        it "updates the requested trade_offer" do
          trade_offer = TradeOffer.create! valid_attributes
          put :update, id: trade_offer.to_param, trade_offer: new_attributes
          trade_offer.reload
        end

        it "assigns the requested trade_offer as @trade_offer" do
          trade_offer = TradeOffer.create! valid_attributes
          put :update, id: trade_offer.to_param, trade_offer: new_attributes
          expect(assigns(:trade_offer)).to eq(trade_offer)
        end

        it "redirects to the trade_offer" do
          trade_offer = TradeOffer.create! valid_attributes
          put :update, id: trade_offer.to_param, trade_offer: new_attributes
          expect(response).to redirect_to(trade_offer)
        end
      end

      describe "with invalid params" do
        it "assigns the trade_offer as @trade_offer" do
          trade_offer = TradeOffer.create! valid_attributes
          put :update, id: trade_offer.to_param, trade_offer: invalid_attributes
          expect(assigns(:trade_offer)).to eq(trade_offer)
        end

        it "re-renders the 'edit' template" do
          trade_offer = TradeOffer.create! valid_attributes
          put :update, id: trade_offer.to_param, trade_offer: invalid_attributes
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      before(:each) do
        login(trade_offer.buyer)
      end

      it "destroys the requested trade_offer" do
        trade_offer = TradeOffer.create! valid_attributes
        expect {
          delete :destroy, id: trade_offer.to_param
        }.to change(TradeOffer, :count).by(-1)
      end

      it "redirects to the trade_offers list" do
        trade_offer = TradeOffer.create! valid_attributes
        delete :destroy, id: trade_offer.to_param
        expect(response).to redirect_to(trade_offers_path)
      end
    end
  end
end
