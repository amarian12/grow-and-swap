class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, format: { with: /\A[A-Za-z][A-Za-z0-9._-]{2,19}\z/ }
  validates :password, length: { minimum: 8 }, allow_nil: true
end
