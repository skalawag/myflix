class ReviewsController < ApplicationController
  def create
    review = Review.create({rating: params[:rating]}.merge(review_params))
    if review && review.valid?
      review.save
      redirect_to show_path(review.video_id)
    else
      flash[:error] = "You cannot submit a blank review!"
      redirect_to show_path(review_params[:video_id])
    end
  end

  private

  def review_params
    params.require(:review).permit(:review, :video_id, :user_id)
  end
end
