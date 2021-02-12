class User < ApplicationRecord
  generate_public_uid column: :unique_code
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.guest
    # 探してなければCreate。Passは変更されても大丈夫なようにランダム
    find_or_create_by!(email: 'guest@example.com', name: 'ゲスト', unique_code: 'guestlogin') do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要!
    end
  end

  has_many :themes, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :tweets

  # foreign_key: 'user_id'が省略されている
  has_many :relations
  # followingsモデルを命名して、実際はRelationモデル※自分がフォローしている人
  has_many :followings, through: :relations, source: :follow
  # （1行目の逆)
  has_many :reverse_of_relations, class_name: 'Relation', foreign_key: 'follow_id'
  # followersモデルを命名※自分をフォローしている人
  has_many :followers, through: :reverse_of_relations, source: :user

  def follow(other_user)
    unless self == other_user
      relations.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relation = relations.find_by(follow_id: other_user.id)
    relation.destroy if relations
  end

  def following?(other_user)
    followings.include?(other_user)
  end

  # active_notifications：自分からの通知※疑似クラス
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  # passive_notifications：相手からの通知※疑似クラス
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  # フォローの通知作成メゾッド
  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ", current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  validates :name, :email, presence: true
  validates :name, length: { minimum: 1, maximum: 20 }
  validates :unique_code, uniqueness: true
  # 5-12文字の半角英数字（更新時のみのバリデーション※新規登録時には自動でランダム登録）
  validates :name, :email, presence: true, on: :update
  validates :unique_code, format: { with: /\A[a-z0-9]+\z/i, message: "は半角英数字である必要があります" }, on: :update
  validates :unique_code, length: { minimum: 5, maximum: 12 }, on: :update

  attachment :profile_image

  # 有効会員はtrue、退会済み会員はfalse
  enum is_active: { 有効: true, 無効: false }
  # is_activeが有効の場合は有効会員(ログイン可能)
  def active_for_authentication?
    super && (is_active === "有効")
  end
end
