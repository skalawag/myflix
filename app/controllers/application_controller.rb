class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  def require_user
    redirect_to new_login_path unless current_user
  end

  def current_user
    current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def destroy_session
    session[:user_id] = nil
  end

  def generate_token
    SecureRandom.urlsafe_base64
  end
end
