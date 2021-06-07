require 'rails_helper'

RSpec.describe MovieService do
  describe 'happy path' do
    it 'can make a successful request to MovieDB' do
      VCR.use_cassette('movie-service') do
        request = MovieService.request("Lord of the Rings")

        expect(request.status).to eq(200)
      end
    end

    it 'can parse the data' do
      VCR.use_cassette('movie-service') do
        data = MovieService.parse_data("Lord of the Rings")

        expect(data).to be_an Array

        data.each do |movie|
          expect(movie).to be_a Hash
        end
      end
    end
  end

  describe 'sad path' do
    
  end
end