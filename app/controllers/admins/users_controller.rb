class Admins::UsersController < ApplicationController
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
end
