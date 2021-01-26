class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @answer = Answer.find(params[:answer_id])
    comment = current_user.comments.new(comment_params)
    comment.answer_id = @answer.id

    if comment.save
      # ここから通知のメゾッド定義（モデルに記載してます）
      @answer.create_notification_comment!(current_user, comment.id)
    # ここまで
    # 非同期化のためリダイレクトしない
    else
      redirect_to answers_path, alert: 'コメントを反映できませんでした…。※1文字以上入力してください。'
    end
  end

  def destroy
    Comment.find_by(id: params[:id], answer_id: params[:answer_id]).destroy
    # destroy.js.erbに渡す変数
    @answer = Answer.find(params[:answer_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end
end
