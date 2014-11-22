class InvitationsController < ApplicationController
  def create
    invitation = Invitation.create(user_id: current_user.id, new_user_email: params[:email], new_user_name: params[:name], token: SecureRandom.urlsafe_base64)
    AppMailer.invite_friend(params[:name], params[:email], params[:message], current_user.username).deliver
    flash[:success] = "Your invitation has been sent."
    redirect_to home_path
  end

  def show
  end
end
