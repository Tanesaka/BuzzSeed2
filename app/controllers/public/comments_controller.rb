class Public::CommentsController < ApplicationController
  def create
    @answer = Answer.find(params[:answer_id])
    comment = current_user.comments.new(comment_params)
    comment.answer_id = @answer.id
    # ここから通知のメゾッド定義（モデルに記載してます）
    @answer.create_notification_comment!(current_user, comment.id)
    # ここまで
    # 非同期化のためリダイレクトしない
    unless comment.save
      redirect_to answers_path, alert: 'コメントを反映できませんでした。※1文字以上入力してください。'
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
