class Admin::VideosController < ApplicationController
  before_filter :require_admin

  def new
    @categories = Category.all.map { |category| "<option>#{category.name}</option>" }.join()
    @video = Video.new
  end

  def create
    @video = Video.new(title: params[:title], description: params[:description])
    if @video.save
      redirect_to home_path
    else
      flash[:error] = "Something went wrong."
      redirect_to new_admin_video_path
    end
  end

  private

  def require_admin
    if not User.find(current_user.id).admin
      flash[:error] = "You are not authorized to access that page."
      redirect_to(home_path)
    end
  end
end
