class SessionController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by email: params[:user][:email]
    if user && user.authenticate(params[:user][:password])
      redirect_to videos_path
    else
      flash[:error] = "Either the email or the password you entered is defective."
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
