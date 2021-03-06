class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    destroy_session if current_user
    @user = User.new(user_params)
    if @user.valid?
      stripe = StripeWrapper::Charge.create(
        :amount => 999,
        :card => params[:stripeToken],
        :description => "Sign up charge for #{@user.email}"
      )
      if stripe.successful?

        @user.save
        AppMailer.welcome_email(@user).deliver

        handle_invitation(@user)
        flash[:success] = "Thank you for choosing Myflix. Please sign in!"

        redirect_to new_login_path
      else
        flash[:error] = stripe.error_message
        render :new
      end
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email)
  end

  def handle_invitation(user)
    follow_if_invited(user)
    delete_invite_if_invited(user)
  end

  def follow_if_invited(user)
    if invitation = Invitation.find_by(new_user_email: user.email)
      inviter = User.find(invitation.user_id)
      inviter.followees << user
      user.followees << inviter
    end
  end

  def delete_invite_if_invited(user)
    if invite = Invitation.find_by(new_user_email: user.email)
      invite.destroy
    end
  end
end
