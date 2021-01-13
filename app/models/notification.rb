class Notification < ApplicationRecord
  # デフォルトの並び順を「作成日時の降順」で指定(常に新しい通知からデータを取得する)
  default_scope -> { order(created_at: :desc) }
  # optional: trueは、nilを許可するもの。いいねの時などはcomment等不要のため
  belongs_to :theme, optional: true
  belongs_to :answer, optional: true
  belongs_to :comment, optional: true

  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true

end
