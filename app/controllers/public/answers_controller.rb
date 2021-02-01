class Public::AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :rankindex]
  before_action :check_guest, only: [:destroy]

  def check_guest
    if current_user.email == 'guest@example.com'
      redirect_to user_path(current_user), alert: 'その操作はゲストユーザーの場合、制限されています。'
    end
  end


  def new
    @answer = Answer.new
  end

  def create
    answer = Answer.new(answer_params)
    answer.user_id = current_user.id
    if answer.save
      @theme = answer.theme
      @theme.create_notification_answer!(current_user, answer.id)
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
    answer = Answer.all.sort { |a, b| b.favorites.count <=> a.favorites.count }
    @answers = Kaminari.paginate_array(answer).page(params[:page])
  end

  def followanswer
    # フォローしているユーザーと自分も含めた全ての投稿を取得
    # following_ids→ モデル間でアソシエーションが完了しているとRailsが自動生成してくれるメソッド
    @answers = Answer.where(user_id: [current_user.id, *current_user.following_ids]).
      page(params[:page]).reverse_order
  end

  def destroy
    answer = Answer.find(params[:id])
    answer.destroy
    redirect_to user_path(current_user)
  end

  private

  def answer_params
    params.require(:answer).permit(:content, :user_id, :theme_id)
  end
end
