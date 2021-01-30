class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # registerableを抜きました。管理者を増やす場合はrails consoleコマンドから。
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true
  has_many :infomations
end
