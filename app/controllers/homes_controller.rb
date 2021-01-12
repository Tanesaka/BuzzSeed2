class HomesController < ApplicationController
  def top
    @answers = Answer.all
    # randomに取得し、idに代入、最後に一倍最初のidを1つ取得
    @answer = Answer.where( 'id >= ?', rand(Answer.first.id..Answer.last.id) ).first
    @favorites = Favorite.all
    @themes = Theme.all
  end

  def about
  end
end