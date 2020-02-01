class Movie < ApplicationRecord
  searchkick

  has_attached_file :poster, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :poster, content_type: /\Aimage\/.*\z/

  has_attached_file :photo, styles: { large: "1000>x1000", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

  has_many :reviews, dependent: :destroy

  validates :title, :director, :description, :length, :poster, :photo, presence: true
end
