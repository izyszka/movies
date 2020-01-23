class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie

  def create
    # review = current_user.create_review(review_params)
    review = Review.create(review_params)
    review.movie = @movie

    current_user.review = review
    redirect_to @movie
  end

  def update
    review = Review.create(review_params)
    review.movie = @movie
    current_user.review = review

    redirect_to @movie
  end

  def destroy
    current_user.review.destroy

    redirect_to @movie
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end
