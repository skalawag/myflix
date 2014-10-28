class SessionController < ApplicationController
  def new
    if current_user
      redirect_to home_path if current_user
    else
      @user = User.new
    end
  end

  def create
    user = User.find_by email: params[:user][:email]
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to videos_path, notice: "You are signed in."
    else
      flash[:error] = "Either the email or the password you entered is defective."
      redirect_to new_login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You are signed out."
  end

  private

  def post_params
    params.require(:user).permit(:email, :password)
  end
end
