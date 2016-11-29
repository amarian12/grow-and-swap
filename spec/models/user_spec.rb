require 'rails_helper'

# This code was copied from an online example. Need to modify before running
RSpec.describe User, :type => :model do
  describe "Validations" do
    context "on a new user" do
      it "is invalid without a first_name" do
        user = User.new(first_name: nil)
        user.valid?
        expect(user.errors[:first_name]).to include("can't be blank")
      end

      it "is invalid without a last_name" do
        user = User.new(last_name: nil)
        user.valid?
        expect(user.errors[:last_name]).to include("can't be blank")
      end

      it "is invalid without an email address" do
        user = User.new(email: nil)
        user.valid?
        expect(user.errors[:email]).to include("can't be blank")
      end

      it "is invalid with a duplicate email address regardless of case" do
        User.create(
          first_name:   "John",
          last_name:    "Doe",
          email:        "j_doe@email.com",
          password:     "password"
        )
        user = User.new(
          first_name:   "Jane",
          last_name:    "Doe",
          email:        "J_Doe@email.com",
          password:     "password"
        )
        user.valid?
        expect(user.errors[:email]).to include("has already been taken")
      end

      it "is invalid with an incorrectly formatted email address" do
        invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]

        invalid_addresses.each do |invalid_address|
          user = User.new(email: invalid_address)
          user.valid?
          expect(user.errors[:email]).to include("is invalid")
        end
      end

      it "is invalid without a password" do
        user = User.new(password: nil, password_confirmation: nil)
        user.valid?
        expect(user.errors[:password]).to include("can't be blank")
      end

      it "is invalid with a short password" do
        user = User.new(password: "short", password_confirmation: "short")
        user.valid?
        expect(user.errors[:password]).to include("is too short (minimum is 8 characters)")
      end

      it "is invalid with a confirmation mismatch" do
        user = User.new(password: "short", password_confirmation: "long")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("doesn't match Password")
      end

      it "is valid with a first_name, last_name, email, and password" do
        user = build(:user)
        expect(user).to be_valid
      end
    end

    context "on an existing user" do
      let(:user) do
        user = create(:user)
        User.find user.id
      end

      it "is valid with no changes" do
        expect(user).to be_valid
      end

      it "is invalid with an empty password" do
        user.password = user.password_confirmation = " "
        expect(user).to_not be_valid
      end

      it "is valid with a new (valid) password" do
        user.password = user.password_confirmation = "new_password"
        expect(user).to be_valid
      end
    end
  end

  describe "Associations" do
    it "has many garden items selling" do
      is_expected.to have_many(:garden_items_selling).dependent(:destroy)
    end

    it "has many produce items through garden items selling" do
      is_expected.to have_many(:produce_items).through(:garden_items_selling)
    end

    it "has many trade offers received through garden items selling" do
      is_expected.to have_many(:trade_offers_received).through(:garden_items_selling)
    end

    it "has many trade offers made" do
      is_expected.to have_many(:trade_offers_made).dependent(:destroy)
    end

    it "has many garden items buying through trade offers made" do
      is_expected.to have_many(:garden_items_buying).through(:trade_offers_made)
    end
  end
end
