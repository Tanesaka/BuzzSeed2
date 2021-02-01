class Admins::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    # ユーザー検索フォームに受け渡す変数
    @q = User.ransack(params[:q])
    # 検索フォームから帰ってきた結果
    @users = @q.result(distinct: true)
  end

  def show
    @user = User.find(params[:id])
    @answers = @user.answers.page(params[:page]).reverse_order

    # ユーザーが持つ全投稿のいいね合計
    @favorites_count = 0
    @answers.each do |answer|
      @favorites_count += answer.favorites.count
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admins_user_path(@user)
  end

  def mytheme
    @user = User.find(params[:user_id])
    @mypage_themes = @user.themes.page(params[:page]).reverse_order
  end

  def myanswer
    @user = User.find(params[:user_id])
    @mypage_answers = @user.answers.page(params[:page]).reverse_order
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admins_users_path
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :unique_code, :is_active)
  end
end
