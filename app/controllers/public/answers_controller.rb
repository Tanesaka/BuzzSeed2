class Public::AnswersController < ApplicationController
  def new
    @answer = Answer.new
  end

  def create
    answer = Answer.new(answer_params)
    answer.user_id = current_user.id
    answer.save
    redirect_to answer_path(answer.id)
  end

  def show
    @answer = Answer.find(params[:id])
    @theme = @answer.theme
    @comment = Comment.new
    
    @review = Review.new
  end

  def index
    @answers = Answer.page(params[:page]).reverse_order
  end

  def destroy
    answer = Answer.find(params[:id])
    answer.destroy
    redirect_to themes_path
  end


  private

  def answer_params
    params.require(:answer).permit(:content, :user_id, :theme_id)
  end
end
