class Information < ApplicationRecord
  belongs_to :admin
  validates :content, :admin_id, presence: true
end
