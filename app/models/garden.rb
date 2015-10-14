class Garden < ActiveRecord::Base
  validates :quantity, presence: true

  belongs_to :user
  has_many :produce_items, dependent: :destroy
end
