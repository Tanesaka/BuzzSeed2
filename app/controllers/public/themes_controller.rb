class Public::ThemesController < ApplicationController
  def new
    @theme = Theme.new
  end

  def create
    @theme = Theme.new(theme_params)
    @theme.user_id = current_user.id
    if @theme.save
    redirect_to themes_path
    else
      render "new"
    end
  end

  def show
    @theme = Theme.find(params[:id])
    @answer = Answer.new
    @answers = @theme.answers.page(params[:page]).reverse_order
  end

  def index
    # kaminariのpageメゾッド、新着順＆ページング
    @themes = Theme.page(params[:page]).reverse_order
  end

    # 回答数順のお題一覧
  def rankindex
    theme = Theme.all.sort {|a,b| b.answers.count <=> a.answers.count}
    @themes = Kaminari.paginate_array(theme).page(params[:page])
    @answer = Answer.new
  end

  def introduction
  end

  def random
    # randomに取得し、idに代入、最後に一倍最初のidを1つ取得
    @theme = Theme.where( 'id >= ?', rand(Theme.first.id..Theme.last.id) ).first
    @count = 0

    # 基本的に回答付きのお題が出るようにする。5回繰り返して全て回答なしであれば繰り返し処理終了。
    while @theme.answers.blank? do
      @theme = Theme.where( 'id >= ?', rand(Theme.first.id..Theme.last.id) ).first
      @count += 1
      if @count == 5
        break
      end
    end
    @answer = Answer.new
  end

  def destroy
    @theme = Theme.find(params[:id])
    @theme.destroy
    redirect_to themes_path
  end

  private

  def theme_params
    params.require(:theme).permit(:image)
  end
end
