class VideosController < ApplicationController

  def index
    @videos = Video.all
    @categories = Category.all
  end

  def video
  end

  def search
    binding.pry
    @videos = Video.search_by_title(params[:search])
  end

  def genre
    @category = Category.find params[:genre]
  end
end
