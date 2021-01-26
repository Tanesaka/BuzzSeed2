class Admins::ThemesController < ApplicationController
  before_action :authenticate_admin!
  def index
    @themes = Theme.page(params[:page]).reverse_order
  end

  def show
    @theme = Theme.find(params[:id])
    @answers = @theme.answers.page(params[:page]).reverse_order
  end

  def destroy
    @theme = Theme.find(params[:id])
    @theme.destroy
    redirect_to admins_themes_path
  end
end
