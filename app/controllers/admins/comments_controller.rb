class Admins::CommentsController < ApplicationController
  before_action :authenticate_admin!
  def destroy
    Comment.find_by(id: params[:id], answer_id: params[:answer_id]).destroy
    redirect_to admins_answer_path(params[:answer_id])
  end
end
