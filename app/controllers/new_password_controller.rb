class NewPasswordController < ApplicationController
  def show
    user = User.find_by(token: params[:id])
    @user_id = user.id if user
    if user
      user.update_column(:token, nil)
    else
      render :expired_token
    end
  end

  def create
    user = User.find(params[:user_id])
    user.password = params[:password]
    if user.save
      flash[:success] = "Your password has been changed. Please log in."
      redirect_to new_login_path
    else
      flash[:error] = "Something has gone wrong. Please try resetting your password again."
      redirect_to reset_password_path
    end
  end
end
