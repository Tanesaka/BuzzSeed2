class Notification < ApplicationRecord
  # optional: trueは、nilを許可するもの。いいねの時などはcomment等不要のため
  # Favoriteとcommentの記載がないのは、1つに対して、複数の通知がくることは
  belongs_to :theme, optional: true
  belongs_to :answer, optional: true
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true

  validates :visitor, :visited, presence: true
end
