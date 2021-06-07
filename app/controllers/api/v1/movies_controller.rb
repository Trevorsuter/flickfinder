class Api::V1::MoviesController < ApplicationController

  def index
    if !params[:query] || params[:query].blank?
      render json: {status: 404, errors: ["Invalid query"]}.to_json, status: 404
    elsif params[:sort] == "release date"
      render json: MovieSerializer.new(find_movie.order(release_date: :desc))
    else
      render json: MovieSerializer.new(find_movie)
    end
  end

  private

  def find_movie
    MovieFacade.find_movies(params[:query])
  end
end