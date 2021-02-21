class HomesController < ApplicationController
  def top
    # 総合データ用
    @all_answers = Answer.all
    # randomに取得し、最大３つを取得
    # 本番環境のMySQLではRAND()が必須
    if Rails.env.development? || Rails.env.test?
      # SQLite
      @answers = Answer.order("RANDOM()").limit(3)
    else
      # mySQL対応(RAND)
      @answers = Answer.order("RAND()").limit(3)
    end


    @all_favorites = Favorite.all
    @themes = Theme.all
    @tweets = Tweet.all

    @informations = Information.limit(2).order("created_at DESC")
  end

  def informations
    @informations = Information.page(params[:page]).reverse_order.per(15)
  end

  def about
  end

  def contact
  end
end
