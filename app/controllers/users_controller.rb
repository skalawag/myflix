class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if u.id?
      redirect_to new_login_path # with errors
    elsif user.valid? && user.save
      redirect_to videos_path # with welcome
    else
      redirect_to registration_path # with errors
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email)
  end
end
