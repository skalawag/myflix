class VideosController < ApplicationController

  def index
    @videos = Video.all
    @categories = Category.all
  end

  def video

  end
end
