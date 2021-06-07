class Movie < ApplicationRecord
  has_many :search_movies
  has_many :searches, through: :search_movies
end
