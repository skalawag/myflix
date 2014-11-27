class Admin::VideosController < ApplicationController
  before_filter :require_admin

  def new
    @video = Video.new
  end

  def create
  end

  private

  def require_admin
    User.find(current_user.id).admin || redirect_to(home_path)
  end
end
