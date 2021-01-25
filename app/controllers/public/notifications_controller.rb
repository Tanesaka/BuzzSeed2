class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!
  def index
    # 並び順を「作成日時の降順」で指定
    @notifications = current_user.passive_notifications.
      order(created_at: :desc).page(params[:page]).per(10)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
end
