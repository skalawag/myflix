class Admin::VideosController < ApplicationController
  before_filter :require_admin

  def new
    @video = Video.new
  end

  def create
    @video = Video.new
    redirect_to home_path
  end

  private

  def require_admin
    if not User.find(current_user.id).admin
      flash[:error] = "You are not authorized to access that page."
      redirect_to(home_path)
    end
  end
end
