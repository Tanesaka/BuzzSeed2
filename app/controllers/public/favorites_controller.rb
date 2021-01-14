class Public::FavoritesController < ApplicationController

  def create
    @answer = Answer.find(params[:answer_id])
    favorite = current_user.favorites.new(answer_id: @answer.id)
    favorite.save
    # いいね非同期化のためリダイレクトしない

    # ここから通知のメゾッド定義（モデルに記載してます）
    @answer.create_notification_like!(current_user)
    # ここまで

# 非同期のjsファイルにある@favorites_countを反映させるために
# Usersコントローラーに続き、ここでも再定義※destroyも同じく。
    @user = @answer.user
    @answers = @user.answers
    @favorites_count = 0
    @answers.each do |answer|
      @favorites_count += answer.favorites.count
    end

    # Topページのいいね非同期化
    @all_favorites = Favorite.all

  end

  def destroy
    @answer = Answer.find(params[:answer_id])
    favorite = current_user.favorites.find_by(answer_id: @answer.id)
    favorite.destroy
    # redirect_to request.referer

    @user = @answer.user
    @answers = @user.answers
    @favorites_count = 0
    @answers.each do |answer|
      @favorites_count += answer.favorites.count
    end

        # Topページのいいね非同期化
    @all_favorites = Favorite.all
  end

  # private
  # def favorite_params
  #   params.require(:favorite).permit(:user_id, :answer_id)
  # end
end
