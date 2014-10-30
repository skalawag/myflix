class Video < ActiveRecord::Base
  has_many :video_categories
  has_many :categories, through: :video_categories
  has_many :reviews, -> { order "created_at DESC" }

  validates :title, presence: true
  validates :description, presence: true

  def self.search_by_title(title)
    where("title LIKE ?", "%#{title}%")
  end

  def average_rating
    self.reviews.map { |r| r.rating }.reduce {|i,j| i + j } / @reviews.count.to_f
  end
end
