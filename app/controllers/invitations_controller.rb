class InvitationsController < ApplicationController
  def create
    AppMailer.invite_friend(params[:name], params[:email], params[:message], current_user.username, current_user.email).deliver
    redirect_to home_path
  end
end
