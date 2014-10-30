class VideosController < ApplicationController
  before_action :require_user

  def index
    # FIXME: This is probably not a good idea. What if we have 100K
    # videos in the database? Do we really want to hit the db like
    # that every time someone opens the index page?
    @videos = Video.all
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
    @reviews = @video.reviews
    @average = @reviews.map { |r| r.rating }.reduce {|i,j| i + j } / @reviews.count.to_f
    @review = Review.new
    @review.user_id = current_user.id
    @review.video_id = @video.id
  end

  def search_by_title
    @videos = Video.search_by_title(params[:search_term])
  end

  def genre
    @category = Category.find params[:genre]
  end
end
