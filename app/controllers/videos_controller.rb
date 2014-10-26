class VideosController < ApplicationController

  def index
    @videos = Video.all
    @categories = Category.all
  end

  def video
  end

  def search_by_title
    @videos = Video.search_by_title(params[:search_term])
  end

  def genre
    @category = Category.find params[:genre]
  end
end
