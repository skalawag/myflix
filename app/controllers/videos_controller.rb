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
  end

  def search_by_title
    @videos = Video.search_by_title(params[:search_term])
  end

  def genre
    @category = Category.find params[:genre]
  end
end
