class VideosController < ApplicationController

  def index
    @videos = Video.all
  end

  def video

  end
end
