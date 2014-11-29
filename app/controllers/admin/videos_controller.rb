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
      @video = Video.new(title: params[:video][:title], description: params[:video][:description])

      if @video.save
        categorize_video(@video)
        flash[:success] = "Your video has been added."
        redirect_to home_path
      else
        flash[:error] = "Try again!"
        redirect_to new_admin_video_path
      end
    end
  end

  private

  def categorize_video(video)
    categories = params[:category].map { |id| Category.find(id) }
    categories.each do |cat|
      video.categories << cat
    end
  end

  def require_admin
    if !current_user.admin
      flash[:error] = "You must be an admin to visit that page."
      redirect_to home_path
    end
  end

end
