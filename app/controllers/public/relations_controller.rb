class Public::RelationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    following = current_user.follow(@user)
    following.save
    # ここから通知のメゾッド定義（モデルに記載してます）
    @user.create_notification_follow!(current_user)
    # 非同期化のためリダイレクトしない
  end

  def destroy
    following = current_user.unfollow(@user)
    following.destroy
  end

  private

  def set_user
    @user = User.find(params[:follow_id])
  end
end
