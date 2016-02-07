class TradeOffer < ActiveRecord::Base
validates :quantity, :accepted, presence: true

belongs_to :buyer, class_name: "User", foreign_key: :user_id

belongs_to :garden_item

has_one :seller, class_name: "User", through: :garden_item

validates_presence_of :buyer, class_name: "User"
validates_presence_of :garden_item
end
