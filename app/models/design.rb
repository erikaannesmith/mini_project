class Design < ApplicationRecord
  validates   :name, :description, presence: true, uniqueness: true
  belongs_to  :user
  has_many    :images, dependent: :destroy
end
