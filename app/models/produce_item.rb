class ProduceItem < ActiveRecord::Base
  validates :name, presence: true
  validates :category, presence: true

  after_validation :normalize_name, on: :create

  has_many :garden_items
  has_many :sellers, through: :garden_items

  accepts_nested_attributes_for :garden_items, reject_if: :all_blank

  protected

  def normalize_name
    self.name = self.name.downcase.titleize unless self.name.nil?
  end
end
