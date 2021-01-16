class HomesController < ApplicationController
  def top
    # 総合データ用
    @all_answers = Answer.all
    # randomに取得し、idに代入、最大３つのidを取得
    @answers = Answer.where('id >= ?', rand(Answer.first.id..Answer.last.id)).limit(3)

    @all_favorites = Favorite.all
    @themes = Theme.all
  end

  def about
  end
end
