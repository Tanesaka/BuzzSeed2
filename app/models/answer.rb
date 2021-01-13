class Answer < ApplicationRecord
  validates :content, :user_id, :theme_id, presence: true

  belongs_to :theme
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

# いいねの通知作成メゾッド
# メソッド名に「!」を付けているのは、「メソッド内でデータ登録もやっているので、呼び出す際は気をつけてね」というのをわかりやすくするため（つけなくても動作する）
  def create_notification_like!(current_user)
        # すでに「いいね」されているか検索
        # プレースホルダ※「?」を指定した値で置き換える。SQLインジェクションを防ぐ
    temp = Notification.where(["visitor_id = ? and visited_id = ? and answer_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成(いたずら防止。いいねを連続でした場合でも、1度しか相手に通知がいかないようにする)
    if temp.blank?
      notification = current_user.active_notifications.new(
        answer_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  # Commentの通知作成メゾッド
  def create_notification_comment!(current_user, comment_id)
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id)
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      answer_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end
