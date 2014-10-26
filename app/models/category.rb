class Category < ActiveRecord::Base
  has_many :video_categories
  has_many :videos, through: :video_categories

  def recent_videos
    self.videos.order(created_at: :desc).limit(6)
  end
end
