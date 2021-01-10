class Public::UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end

  def show
    @user = User.find(params[:id])
    # いいね総数の合計元の回答数と分けるために別途変数を定義
    @mypage_answers = @user.answers.page(params[:page]).reverse_order

    # ユーザーが持つ全投稿のいいね合計
    @answers = @user.answers
    @favorites_count = 0
    @answers.each do |answer|
      @favorites_count += answer.favorites.count
    end
  end

  def index
    @users = User.all
  end

  def following
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def follower
    user = User.find(params[:user_id])
    @users = user.followers
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :unique_code)
  end
end
