class TradeOffer < ActiveRecord::Base
  validates :quantity, presence: true

  belongs_to :buyer, class_name: "User", foreign_key: :user_id

  belongs_to :garden_item, foreign_key: :garden_item_id

  has_one :seller, class_name: "User", through: :garden_item

  belongs_to :initial_trade_offer, class_name: "TradeOffer", foreign_key: :initial_trade_offer_id

  validates_presence_of :buyer, class_name: "User", foreign_key: :user_id
  validates_presence_of :garden_item

  def initial?
    self.initial_trade_offer_id.nil?
  end

  def reciprocated?
    self.initial_trade_offer_id != nil
  end

  def received?
    self.seller == current_user
  end
end
