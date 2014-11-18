class ResetPasswordController < ApplicationController
  def create
    user = User.find_by email: params[:email]
    if user
      user.update_column(:token, SecureRandom.urlsafe_base64)
      AppMailer.reset_password(user.reload).deliver
      redirect_to reset_password_confirmation_path
    else
      render :new
    end
  end
end
