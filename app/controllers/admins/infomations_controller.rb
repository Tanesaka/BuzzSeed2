class Admins::InfomationsController < ApplicationController
  before_action :authenticate_admin!
  def new
    @infomation = Infomation.new
  end

  def create
    @infomation = Infomation.new(infomation_params)
    @infomation.admin_id = current_admin.id
    @infomation.save
    redirect_to admins_infomations_path
  end

  def destroy
    infomation = Infomation.find(params[:id])
    infomation.destroy
    redirect_to admins_infomations_path
  end

  def index
    @infomation = Infomation.new
    @infomations = Infomation.page(params[:page]).reverse_order.per(15)
  end


  private

  def infomation_params
    params.require(:infomation).permit(:content, :admin_id)
  end
end
