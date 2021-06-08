require 'rails_helper'

RSpec.describe MovieFacade do
  before :each do
    VCR.use_cassette('movie-service') do
      @movie_results = MovieService.parse_data("Lord of the Rings")
    end
  end

  describe 'happy path' do
    it 'creates new movies' do
      VCR.use_cassette('movie-facade', allow_playback_repeats: true) do
        expect(Movie.all).to be_empty

        new_movies = MovieFacade.create_movies("Lord of the Rings")

        expect(Movie.all).to_not be_empty
        
        @movie_results.each do |movie|
          expect(Movie.find_by(id: movie[:id])).to_not be_nil
        end
      end
    end

    it 'creates a new search with the query downcased' do
      VCR.use_cassette('movie-facade', allow_playback_repeats: true) do
        expect(Search.all).to be_empty

        search = MovieFacade.new_search("Lord of the Rings")

        expect(Search.all.length).to eq(1)
        expect(Search.first.query).to eq("lord of the rings")
      end
    end

    it 'creates a new search movie' do
      VCR.use_cassette('movie-facade', allow_playback_repeats: true) do
        expect(SearchMovie.all).to be_empty

        search_movies = MovieFacade.create_records("Lord of the Rings")
        search = Search.find_by(query: "lord of the rings")

        expect(SearchMovie.all).to_not be_empty

        SearchMovie.all.each do |search_movie|
          expect(search_movie.search).to eq(search)
        end

        Movie.all.each do |movie|
          expect(movie.searches).to include(search)
        end
      end
    end

    it 'will create new records if the query doesnt exist' do
      VCR.use_cassette('movie-facade', allow_playback_repeats: true) do
        expect(Search.find_by(query: "Lord of the Rings")).to be_nil
        expect(Movie.all).to be_empty
        expect(SearchMovie.all).to be_empty

        MovieFacade.find_movies("Lord of the Rings")

        expect(Search.find_by(query: "Lord of the Rings".downcase)).to_not be_nil
        expect(Movie.all).to_not be_empty
        expect(SearchMovie.all).to_not be_empty
      end
    end
  end

  describe 'sad path' do
    it 'will not create a new movie' do
      VCR.use_cassette('movie-facade', allow_playback_repeats: true) do
        movie = @movie_results.first
        created_movie = MovieFacade.new_movie(movie)
        movies = MovieFacade.create_movies("Lord of the Rings")
        
        expect(movies).to include(created_movie).once
      end
    end

    it 'will not create new records if the query exists' do
      VCR.use_cassette('movie-facade', allow_playback_repeats: true) do
        Search.create(query: 'lord of the rings')
        find_movies = MovieFacade.find_movies('Lord of the Rings')

        expect(find_movies).to be_empty
      end
    end
  end
end