class Admins::InformationsController < ApplicationController
  before_action :authenticate_admin!
  def new
    @information = Information.new
  end

  def create
    @information = Information.new(information_params)
    @information.admin_id = current_admin.id
    @information.save
    redirect_to admins_informations_path
  end

  def destroy
    information = Information.find(params[:id])
    information.destroy
    redirect_to admins_informations_path
  end

  def index
    @information = Information.new
    @informations = Information.page(params[:page]).reverse_order.per(15)
  end


  private

  def information_params
    params.require(:information).permit(:content, :admin_id)
  end
end
