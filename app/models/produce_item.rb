class ProduceItem < ActiveRecord::Base
  validates :name, presence: true
  validates :category, presence: true

  has_many :garden_items
  has_many :users, through: :garden_items
end
