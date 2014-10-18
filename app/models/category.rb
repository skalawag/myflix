class Category < ActiveRecord::Base
  has_many :video_categories, -> { order("title") }
  has_many :videos, through: :video_categories
end