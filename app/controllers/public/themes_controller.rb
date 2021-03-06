class Public::ThemesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :rankindex, :show]
  def new
    @theme = Theme.new
  end

  def create
    @theme = Theme.new(theme_params)
    @theme.user_id = current_user.id
    if @theme.save
      # Vision APIでラベル取得
      theme_tags = Vision.get_image_data(@theme.image)
      theme_tags.each do |theme_tag|
        # Translate APIで翻訳して保存
       @theme.theme_tags.create(name: Translate.translate_to_japanese(theme_tag))
      end
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
    theme = Theme.all.sort { |a, b| b.answers.count <=> a.answers.count }
    @themes = Kaminari.paginate_array(theme).page(params[:page])
    @answer = Answer.new
  end

  def tagsearch
    @themes = Theme.joins(:theme_tags).where(theme_tags: {name: params[:theme_tag_name]}).page(params[:page]).reverse_order
  end

  def introduction
  end

  def random
    # randomに取得し、idに代入、最後に一倍最初のidを1つ取得
    @theme = Theme.where('id >= ?', rand(Theme.first.id..Theme.last.id)).first
    @count = 0

    # 基本的に回答付きのお題が出るようにする。繰り返して全て回答なしであれば繰り返し処理終了。
    while @theme.answers.blank?
      @theme = Theme.where('id >= ?', rand(Theme.first.id..Theme.last.id)).first
      @count += 1
      # 確率を操作する場合は下記数字を変更
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
