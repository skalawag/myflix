class Review < ActiveRecord::Base
  validates_presence_of :review, :rating

  belongs_to :user
  belongs_to :video
end
