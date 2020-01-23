class Movie < ApplicationRecord
  has_attached_file :poster, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :poster, content_type: /\Aimage\/.*\z/

  has_many :reviews, dependent: :destroy

  validates :title, :director, :description, :length, :poster, presence: true
end
