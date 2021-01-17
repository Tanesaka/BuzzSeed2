class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :answer
  has_many :notifications, dependent: :destroy

  validates :content, :user_id, :answer_id, presence: true
  validates :content, length: { minimum: 1, maximum: 200 }
end
