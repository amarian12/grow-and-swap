class ProduceItem < ActiveRecord::Base
  validates :name, presence: true
  validates :category, presence: true

  after_validation :normalize_name, on: :create

  has_many :garden_items
  has_many :users, through: :garden_items

  protected

  def normalize_name
    self.name = self.name.downcase.titleize unless self.name.nil?
  end
end
