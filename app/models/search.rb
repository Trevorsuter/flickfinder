class Search < ApplicationRecord
  validates :query, presence: true

  has_many :search_movies
  has_many :movies, through: :search_movies
end
