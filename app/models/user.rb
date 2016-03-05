class User < ActiveRecord::Base
  attr_accessor :remember_token

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/ }
  validates :password, length: { minimum: 8 }, allow_nil: true

  before_save { self.email = email.downcase }

  has_many :garden_items_selling, class_name: "GardenItem",
           inverse_of: :seller, dependent: :destroy

  has_many :produce_items, through: :garden_items_selling, source: :garden_items

  has_many :trade_offers_received, class_name: "TradeOffer",
           through: :garden_items_selling, source: :trade_offers_made

  has_many :trade_offers_made, class_name: "TradeOffer",
           inverse_of: :buyer, dependent: :destroy

  has_many :garden_items_buying, class_name: "GardenItem",
           through: :trade_offers_made, source: :garden_items

  accepts_nested_attributes_for :garden_items_selling, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :trade_offers_made, allow_destroy: true, reject_if: :all_blank

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def full_name
    self.first_name << " " << self.last_name
  end
end
