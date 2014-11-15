class User < ActiveRecord::Base
  has_many :follower_relations
  has_many :followees, through: :follower_relations

  validates_presence_of :email, :username, :password
  validates_uniqueness_of :email
  has_secure_password validations: false
  has_many :reviews

  has_many :queued_videos
  has_many :videos, through: :queued_videos

  def find_rating(video)
    review = Review.find_by(user_id: self.id, video_id: video.id)
    if not review
      ""
    elsif review.rating == 1
      "1 Star"
    else
      "#{review.rating} Stars"
    end
  end

  def update_ratings(ratings)
    ratings.each do |rating|
      review = Review.find_by(user_id: self.id, video_id: rating["id"])
      if review.nil?
        review = Review.create(user_id: self.id,
                               video_id: rating["id"],
                               review: "Nothing here yet! Add your review.",
                               rating: rating["rating"])
      end
      if review.rating != fix_rating(rating["rating"])
        review.update(rating: fix_rating(rating["rating"]))
      end
    end
  end

  def fix_rating(rating)
    if rating.blank?
      rating
    else
      rating[0].strip
    end
  end
end
