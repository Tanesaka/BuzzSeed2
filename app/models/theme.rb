class Theme < ApplicationRecord
  belongs_to :user

  # 画像のカラム名に合わせる
  attachment :image

  validates :image, :user_id, presence: true

  has_many :answers, dependent: :destroy
  has_many :notifications, dependent: :destroy

  # Answerの通知作成メゾッド
  def create_notification_answer!(current_user, answer_id)
  end

  def save_notification_answer!(current_user, answer_id, visited_id)
    # ヒトコトは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      theme_id: id,
      answer_id: answer_id,
      visited_id: visited_id,
      action: 'answer'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end


end
