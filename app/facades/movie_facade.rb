class MovieFacade

  def self.find_movies(query)
    create_records(query) if Search.find_by(query: query.downcase).nil?
    Search.find_by(query: query.downcase).movies
  end

  def self.create_records(query)
    search = new_search(query)
    movies = create_movies(query)
    
    movies.each do |movie|
      SearchMovie.create(search: search, movie: movie)
    end
  end

  def self.create_movies(query)
    data = MovieService.parse_data(query)
    data.map do |movie|
      if !Movie.find_by(id: movie[:id]).nil?
        Movie.find(movie[:id])
      else
        new_movie(movie)
      end
    end
  end

  def self.new_search(query)
    Search.create(query: query.downcase)
  end

  def self.new_movie(movie)
    Movie.create(id: movie[:id],
                      title: movie[:title],
                      release_date: movie[:release_date],
                      description: movie[:overview],
                      popularity: movie[:popularity].to_d,
                      vote_average: movie[:vote_average].to_d
                    )
  end
end