class ProduceItem < ActiveRecord::Base
  validates :name, presence: true
  validates :category, presence: true

  belongs_to :garden
  belongs_to :user
end
