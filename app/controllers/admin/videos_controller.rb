class Admin::VideosController < ApplicationController
  before_filter :require_admin

  def new
    @video = Video.new
  end

  def create
    if params[:video].nil? || params[:category].nil?
      flash[:error] = "Try again!"
      redirect_to new_admin_video_path
    else
      @categories = params[:category].map { |id| Category.find(id) }
      @video = Video.new(title: params[:video][:title], description: params[:video][:description])
      if @video.save
        flash[:success] = "Your video has been added."
        redirect_to home_path
      else
        flash[:error] = "Try again!"
        redirect_to new_admin_video_path
      end
    end
  end

  private

  def require_admin
    if !current_user.admin
      flash[:error] = "You must be an admin to visit that page."
      redirect_to home_path
    end
  end

end
