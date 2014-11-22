class InvitationsController < ApplicationController
  def create
    AppMailer.invite_friend(params[:name], params[:email], params[:message], current_user.username, current_user.email).deliver
    flash[:success] = "Your invitation has been sent."
    redirect_to home_path
  end
end
