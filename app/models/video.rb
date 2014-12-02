class Video < ActiveRecord::Base
  has_many :video_categories
  has_many :categories, through: :video_categories
  has_many :reviews, -> { order "created_at DESC" }

  has_many :queued_videos
  has_many :users, through: :queued_videos

  validates :title, presence: true
  validates :description, presence: true

  mount_uploader :small_cover, SmallCoverUploader
  mount_uploader :large_cover, LargeCoverUploader


  def self.search_by_title(title)
    where("title LIKE ?", "%#{title}%")
  end

  def average_rating
    total_rating = self.reviews.map { |r| r.rating }.reduce {|i,j| i + j }
    if total_rating.nil?
      return 0
    else
      num_of_reviews = self.reviews.count.to_f
      total_rating / num_of_reviews
    end
  end
end
