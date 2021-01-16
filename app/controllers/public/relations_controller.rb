class Public::RelationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    following = current_user.follow(@user)
    following.save

    # ここから通知のメゾッド定義（モデルに記載してます）
    @user.create_notification_follow!(current_user)
    # ここまで

    # 非同期化のためリダイレクトしない
  end

  def destroy
    following = current_user.unfollow(@user)
    following.destroy
    # if following.destroy
    #   redirect_to request.referer
    # else
    #   flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
    #   redirect_to request.referer
    # end
  end

  private

  def set_user
    @user = User.find(params[:follow_id])
  end
end
