class ResetPasswordController < ApplicationController
  def create
    user = User.find_by email: params[:email]
    if user
      token = SecureRandom.urlsafe_base64
      user.update_column(:token, token)
      AppMailer.reset_password(user.reload).deliver
      redirect_to reset_password_confirmation_path
    else
      render :new
    end
  end
end
