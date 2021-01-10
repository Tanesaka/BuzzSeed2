class Public::RelationsController < ApplicationController
  before_action :set_user

  def create
    following = current_user.follow(@user)
    following.save
    # if following.save
    #   redirect_to request.referer
    # else
    #   flash.now[:alert] = 'ユーザーのフォローに失敗しました'
    #   redirect_to request.referer
    # end
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