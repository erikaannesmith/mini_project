class Contact < ApplicationRecord
    validates :company, :contact_name, :location, :phone_number, :email, :industry, presence: true
    validates_uniqueness_of :company, :contact_name
    has_many :partnerships, dependent: :destroy
    has_many :users, through: :partnerships
end
