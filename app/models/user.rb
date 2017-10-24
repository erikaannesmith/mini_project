class User < ApplicationRecord
  has_secure_password
  validates :email, :location, :company_name, :website, presence: true
  validates_uniqueness_of :email, :company_name, :website
end
