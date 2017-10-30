class Image < ApplicationRecord
    validates :image_file_name, :image_content_type, :image_file_size, presence: true
    belongs_to :design
    has_attached_file :image
    validates_attachment_content_type :image, :content_type => ['image/jpg', 'image/jpeg', 'image/png']
end