class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie
  before_action :set_review, only: [:update, :destroy]

  def create
    review = Review.new(review_params)
    review = @movie.reviews.build(review_params)
    review.user_id = current_user.id

    review.save
    redirect_to @movie
  end

  def update
    @review.update(review_params)
    redirect_to @movie
  end

  def destroy
    @review.destroy
    redirect_to @movie
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def set_review
    @review = @movie.reviews.find_by(user_id: current_user.id)
  end
end
