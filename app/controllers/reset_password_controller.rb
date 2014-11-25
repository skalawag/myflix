class ResetPasswordController < ApplicationController
  def create
    user = User.find_by email: params[:email]
    if user
      user.update_column(:token, generate_token)
      AppMailer.reset_password(user.reload).deliver
      redirect_to reset_password_confirmation_path
    else
      flash[:error] = "The email you entered is not a valid user's email."
      render :new
    end
  end
end
