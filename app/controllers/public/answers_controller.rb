class Public::AnswersController < ApplicationController
  def new
    @answer = Answer.new
  end

  def create
    answer = Answer.new(answer_params)
    answer.user_id = current_user.id
    if answer.save
    redirect_to theme_path(answer.theme_id)
    else
      # お題一覧画面へ推移
      redirect_to themes_path, alert: '回答を反映できませんでした…。※1文字以上入力してください。'
    end
  end

  def show
    @answer = Answer.find(params[:id])
    @theme = @answer.theme
    @comment = Comment.new
  end

  def index
    @answers = Answer.page(params[:page]).reverse_order
  end

  # いいね数順の回答一覧
  def rankindex
    answer = Answer.all.sort {|a,b| b.favorites.count <=> a.favorites.count}
    @answers = Kaminari.paginate_array(answer).page(params[:page])
  end

  def destroy
    answer = Answer.find(params[:id])
    answer.destroy
    redirect_to answers_path
  end


  private

  def answer_params
    params.require(:answer).permit(:content, :user_id, :theme_id)
  end
end
