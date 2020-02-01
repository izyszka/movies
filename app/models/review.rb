class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :rating, presence: true
  validates :user_id, uniqueness: { scope: :movie_id }
end
