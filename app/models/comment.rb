class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :answer

  validates :content, :user_id, :answer_id, presence: true
end
