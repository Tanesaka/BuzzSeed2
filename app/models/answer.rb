class Answer < ApplicationRecord
  validates :content, :user_id, :theme_id, presence: true

  belongs_to :theme
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end
