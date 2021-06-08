class MovieSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :release_date, :description, :popularity, :vote_average

  has_many :searches, through: :search_movies
end
