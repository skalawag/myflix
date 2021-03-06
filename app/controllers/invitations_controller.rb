class InvitationsController < ApplicationController
  def create
    token = generate_token
    invitation = Invitation.create(user_id: current_user.id, new_user_email: params[:email], new_user_name: params[:name], token: token)

    if invitation.valid?
      AppMailer.delay.invite_friend(params[:name], params[:email], params[:message], current_user.username, token)
      flash[:success] = "Your invitation has been sent."
      redirect_to home_path
    else
      flash[:error] = "Something was wrong with your invitation."
      render :new
    end
  end

  def show
    @user = User.new
    @invitation = Invitation.find_by(token: params[:id])
    if not @invitation
      redirect_to new_user_path
    end
  end
end
