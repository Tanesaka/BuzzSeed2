class Public::CommentsController < ApplicationController
  def create
    answer = Answer.find(params[:answer_id])
    comment = current_user.comments.new(comment_params)
    comment.answer_id = answer.id
    if comment.save
    redirect_to answer_path(answer)
    else
      # 回答一覧画面へ推移
      redirect_to answers_path, alert: 'コメントを反映できませんでした…。※1文字以上入力してください。'
    end
  end

  def destroy
    Comment.find_by(id: params[:id], answer_id: params[:answer_id]).destroy
    redirect_to answer_path(params[:answer_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
