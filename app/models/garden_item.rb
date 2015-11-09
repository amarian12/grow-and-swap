class GardenItem < ActiveRecord::Base
  validates :quantity, presence: true

  belongs_to :user #, inverse_of: :garden_item
  belongs_to :produce_item

  validates_presence_of :user
  validates_presence_of :produce_item

  accepts_nested_attributes_for :produce_item, reject_if: :all_blank
end
