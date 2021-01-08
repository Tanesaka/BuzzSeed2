class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :answer
  validates :user_id, :answer_id, presence: true
end
