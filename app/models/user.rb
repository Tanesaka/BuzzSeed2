class User < ApplicationRecord
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
      self.relations.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relation = self.relations.find_by(follow_id: other_user.id)
    relation.destroy if relations
  end
User
  def following?(other_user)
    self.followings.include?(other_user)
  end



  validates :name, :unique_code, :email, presence: true
  validates :name, length: { minimum: 2, maximum: 20}
  validates :unique_code, uniqueness: true
  # 5-12文字の半角英数字
  validates :unique_code, format: { with: /\A[a-z0-9]+\z/i,message: "は半角英数字である必要があります"}
  validates :unique_code, length: { minimum: 5, maximum: 12}


  attachment :profile_image
end
