class Notification < ApplicationRecord
  # optional: trueは、nilを許可するもの。いいねの時などはcomment等不要のため
  belongs_to :theme, optional: true
  belongs_to :answer, optional: true
  belongs_to :comment, optional: true

  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
end
