class ProduceItem < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :category, presence: true

  after_validation :normalize_name, on: :create

  has_many :garden_items
  has_many :sellers, class_name: "User", through: :garden_items

  accepts_nested_attributes_for :garden_items, reject_if: :all_blank

  protected

  def normalize_name
    self.name = self.name.downcase.titleize unless self.name.nil?
  end
end
