class Tweet < ApplicationRecord
  validates :user_id, presence: true
  validates :content, length: { minimum: 1, maximum: 60 }
  belongs_to :user
end
