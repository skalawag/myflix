class ReviewsController < ApplicationController
  def create
    review = Review.create({rating: params[:rating]}.merge(post_params))
    if review && review.valid?
      review.save
      redirect_to "/video/#{review.video_id}"
    else
      flash[:error] = "You cannot submit a blank review!"
      redirect_to "/video/#{post_params[:video_id]}"
    end
  end

  private

  def post_params
    params.require(:review).permit(:review, :video_id, :user_id)
  end
end
