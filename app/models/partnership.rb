class Partnership < ApplicationRecord
    belongs_to :contact
    belongs_to :user    
    validates_uniqueness_of :user_id, {scope: :contact_id}
end