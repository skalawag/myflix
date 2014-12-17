class VideoDecorator < Draper::Decorator
  delegate_all

  def average_rating
    total_rating = object.reviews.map { |r| r.rating }.reduce {|i,j| i + j }
    if total_rating.nil?
      return 0
    else
      num_of_reviews = object.reviews.count.to_f
      result = total_rating / num_of_reviews
      result.round(1)
    end
  end
end
