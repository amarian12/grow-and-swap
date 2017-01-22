class TradeOffer < ActiveRecord::Base
  validates :quantity, presence: true

  # The buyer creates the trade offer when they want a garden item
  belongs_to :buyer, class_name: "User", foreign_key: :user_id

  belongs_to :garden_item, foreign_key: :garden_item_id

  # The seller receives a trade offer for a garden item the buyer wants
  has_one :seller, class_name: "User", through: :garden_item

  # The reciprocal trade offer is the opposite trade offer that makes up a
  #   trade deal. It exists only if a second trade offer was made. There is
  #   a max of two trade offers in a trade deal both of which should have a
  #   reciprocal trade offer.
  belongs_to :reciprocal_trade_offer, class_name: "TradeOffer",
                                      foreign_key: :reciprocal_trade_offer_id

  validates_presence_of :buyer, class_name: "User", foreign_key: :user_id
  validates_presence_of :garden_item, foreign_key: :garden_item_id

  def reciprocated?
    self.reciprocal_trade_offer_id != nil
  end

  def accepted_status
    if self.accepted?
      "Accepted"
    else
      "Not accepted"
    end
  end
end
