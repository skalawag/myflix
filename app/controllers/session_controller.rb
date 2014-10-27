class SessionController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by email: params[:user][:email]
    if user && user.authenticate(params[:user][:password])
      redirect_to videos_path
    else
      redirect_to new_login_path
    end
  end

  def destroy
  end

  private

  def post_params
    params.require(:user).permit(:email, :password)
  end
end
