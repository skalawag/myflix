class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    destroy_session if current_user
    @user = User.new(user_params)
    if @user.valid? && @user.save
      AppMailer.welcome_email(@user).deliver
      delete_invite_if_invited(@user)
      redirect_to home_path
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

  def delete_invite_if_invited(user)
    if invite = Invitation.find_by(new_user_email: user.email)
      invite.destroy
    end
  end
end
