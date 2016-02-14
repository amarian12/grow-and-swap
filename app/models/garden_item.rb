class GardenItem < ActiveRecord::Base
  validates :quantity, presence: true

  belongs_to :seller, class_name: "User", foreign_key: :user_id,
           inverse_of: :garden_items_selling

  belongs_to :produce_item

  has_many :trade_offers_made, class_name: "TradeOffer", inverse_of: :garden_item

  has_many :buyers, class_name: "User", through: :trade_offers_made

  accepts_nested_attributes_for :trade_offers_made, reject_if: :all_blank

  validates_presence_of :seller
  validates_presence_of :produce_item
end
