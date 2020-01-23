class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    movie = Movie.find(params[:movie_id])
    user = current_user
    # review = current_user.create_review(review_params)
    review = Review.create(review_params)
    review.movie = movie
    user.review = review

    redirect_to movie
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
