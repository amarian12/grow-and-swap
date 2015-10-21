class ProduceItem < ActiveRecord::Base
  validates :name, presence: true
  validates :category, presence: true

  has_many :gardens
  has_many :users, through: :gardens
end
