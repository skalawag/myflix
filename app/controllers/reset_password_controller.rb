class ResetPasswordController < ApplicationController
  def create
    user = User.find_by email: params[:email]
    if user
      user.token = SecureRandom.urlsafe_base64
      AppMailer.reset_password(user).deliver
      redirect_to reset_password_confirmation_path
    else
      render :new
    end
  end

  def show
    # at the point where i need to follow the link from the email to
    # this controller action, but i can't do it from my chromebook
    # because letter_opener isn't opening the page automatically
    # across the network (or so i hope). try it on the desktop
  end
end
