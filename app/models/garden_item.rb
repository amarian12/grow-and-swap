class GardenItem < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader

  before_validation :check_photo, on: [:create, :update]

  validates :quantity, presence: true

  belongs_to :seller, class_name: "User", foreign_key: :user_id,
           inverse_of: :garden_items_selling

  belongs_to :produce_item

  has_many :trade_offers_made, class_name: "TradeOffer",
           inverse_of: :garden_item, dependent: :destroy

  has_many :buyers, class_name: "User", through: :trade_offers_made

  accepts_nested_attributes_for :trade_offers_made, allow_destroy: true, reject_if: :all_blank

  validates_presence_of :seller
  validates_presence_of :produce_item

  def self.current_user_garden_items(user)
    GardenItem.where(id: user.garden_items_selling)
  end

  def self.other_users_garden_items(user)
    GardenItem.all.where.not(id: user.garden_items_selling)
  end

  def check_photo
    self.photo = self.produce_item.photo if self.photo.blank?
  end
end
