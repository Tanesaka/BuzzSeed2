class HomesController < ApplicationController
  def top
    # 総合データ用
    @all_answers = Answer.all
    # randomに取得し、最大３つを取得

    # 開発環境では下記。MySQLではRAND()が必須
    @answers = Answer.order("RANDOM()").limit(3)
    # @answers = Answer.order("RAND()").limit(3)

    @all_favorites = Favorite.all
    @themes = Theme.all
  end

  def about
  end

  def contact
  end
end
