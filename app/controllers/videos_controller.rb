class VideosController < ApplicationController
  before_action :require_user

  def index
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
    @reviews = @video.reviews
    @average = @video.average_rating
    @review = Review.new(user_id: current_user.id, video_id: @video.id)
  end

  def search_by_title
    @videos = Video.search_by_title(params[:search_term])
  end

  def genre
    @category = Category.find params[:genre]
  end
end
