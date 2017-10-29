class Design < ApplicationRecord
  validates :name, :description, presence: true, uniqueness: true
  belongs_to :user
  has_attached_file :image
  validates_attachment_content_type :image, :content_type => ['image/jpg', 'image/jpeg', 'image/png']
end
