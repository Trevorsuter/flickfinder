require 'rails_helper'

RSpec.describe 'movie request spec' do
  describe 'happy path' do
    describe 'with no sorting' do
      before :each do
        VCR.use_cassette('movie-request') do
          params = {query: "Lord of the Rings"}
          get api_v1_movies_path, params: params
  
          @result = JSON.parse(response.body, symbolize_names: true)
        end
      end
      it 'has a successful response' do
  
        expect(response).to be_successful
        expect(response.status).to eq(200)
      end
  
      it 'has the correct output' do
  
        expect(@result).to have_key(:data)
        @result[:data].each do |movie|
          expect(movie).to have_key(:id)
          expect(movie).to have_key(:type)
          expect(movie[:type]).to eq("movie")
          expect(movie).to have_key(:attributes)
          expect(movie).to have_key(:relationships)
  
          expect(movie[:attributes]).to have_key(:title)
          expect(movie[:attributes]).to have_key(:release_date)
          expect(movie[:attributes]).to have_key(:description)
          expect(movie[:attributes]).to have_key(:popularity)
          expect(movie[:attributes]).to have_key(:vote_average)
        end
      end
  
      it 'only shows movies associated with that query' do
        search = Search.find_by(query: "lord of the rings")
        search_movies = search.movies.pluck(:id)
  
        @result[:data].each do |movie|
          expect(search_movies).to include(movie[:id].to_i)
        end
      end
    end
    describe 'with sorting' do
      before :each do
        VCR.use_cassette('movie-request') do
          params = {query: "Lord of the Rings", sort: "release date"}
          get api_v1_movies_path, params: params
  
          @result = JSON.parse(response.body, symbolize_names: true)
        end
      end
  
      it 'has a successful response' do
  
        expect(response).to be_successful
        expect(response.status).to eq(200)
      end
  
      it 'has the correct output' do
  
        expect(@result).to have_key(:data)
        @result[:data].each do |movie|
          expect(movie).to have_key(:id)
          expect(movie).to have_key(:type)
          expect(movie[:type]).to eq("movie")
          expect(movie).to have_key(:attributes)
          expect(movie).to have_key(:relationships)
  
          expect(movie[:attributes]).to have_key(:title)
          expect(movie[:attributes]).to have_key(:release_date)
          expect(movie[:attributes]).to have_key(:description)
          expect(movie[:attributes]).to have_key(:popularity)
          expect(movie[:attributes]).to have_key(:vote_average)
        end
      end
  
      it 'only shows movies associated with that query' do
        search = Search.find_by(query: "lord of the rings")
        search_movies = search.movies.pluck(:id)
  
        @result[:data].each do |movie|
          expect(search_movies).to include(movie[:id].to_i)
        end
      end
  
      it 'should allow for sorting by release date' do
      
        dates = @result[:data].map do |movie|
          movie[:attributes][:release_date]
        end
  
        (dates.length).times do
          index = 1
          expect(dates[index].to_date).to be < (dates[index - 1]).to_date
          index += 1 
        end
      end
    end
  end
  
  describe 'sad path' do
    it 'returns 404 if query is missing' do
      VCR.use_cassette('movie-search-failure') do
        get api_v1_movies_path
        result = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response.status).to eq(404)

        expect(result[:status]).to eq(404)
        expect(result[:errors]).to include("Invalid query")
      end
    end
    it 'returns 404 if query is blank' do
      VCR.use_cassette('movie-search-failure') do
        params = {query: ""}.to_json
        get api_v1_movies_path, params: params
        result = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response.status).to eq(404)
        expect(result[:status]).to eq(404)
        expect(result[:errors]).to include("Invalid query")
      end
    end
  end
end