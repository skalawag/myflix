class VideosController < ApplicationController

  def index
    @videos = Video.all
    @categories = Category.all
  end

  def video
  end

  def genre
    @category = Category.find params[:genre]
  end
end
