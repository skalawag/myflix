class Category < ActiveRecord::Base
  has_many :video_categories, -> { order("title") }
  has_many :videos, through: :video_categories
  validates_presence_of :name

  def recent_videos
    self.videos.order(created_at: :desc).limit(6)
  end
end
