class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_user
    redirect_to new_login_path unless current_user
  end

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  # in order for any of the methods here to be called from a template,
  # we need to make them helper methods
  helper_method :current_user
end
