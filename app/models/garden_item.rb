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

  def self.sort_by_name
    joins(:produce_item).order("produce_items.name")
  end

  def self.current_user_garden_items(user)
    where(id: user.garden_items_selling)
  end

  def self.garden_items_near_me(user)
    nearby_sellers = User.near([user.latitude, user.longitude], 20)
    seller_ids = nearby_sellers.each_with_object([]) { |s, a| a.push(s.id) }

    joins(:seller, :produce_item)
      .where(user_id: seller_ids)
      .where.not(id: user.garden_items_selling)
  end

  def check_photo
    self.photo = self.produce_item.photo if self.photo.blank?
  end
end
