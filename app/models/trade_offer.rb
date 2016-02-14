class TradeOffer < ActiveRecord::Base
  validates :quantity, presence: true

  belongs_to :buyer, class_name: "User", foreign_key: :user_id

  belongs_to :garden_item, foreign_key: :garden_item_id

  has_one :seller, class_name: "User", through: :garden_item

  validates_presence_of :buyer, class_name: "User", foreign_key: :user_id
  validates_presence_of :garden_item
end
