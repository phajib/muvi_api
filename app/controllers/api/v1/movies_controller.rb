class MoviesController < ApplicationController
    require 'rest-client'

    MUVI_API_KEY = ENV['TMDB_API_KEY']

    def all_movies
        movies = Movie.all
        render json: movies.to_json( :include => {
            :genres => {:except => [:created_at, :updated_at]},
            :except => [:created_at, :updated_at]})
    end

    def movie_details
        movie_api_id = params[:id]
        movie_details_url = "https://api.themoviedb.org/3/movie/#{movie_api_id}?api_key=#{MUVI_API_KEY}&language=en-US"
        response = RestClient.get("#{movie_api_url}")
        render json: response
    end

    def latest_movies
        latest_url = "https://api.themoviedb.org/3/movie/latest?api_key=#{MUVI_API_KEY}&language=en-US"
        response = RestClient.get("#{latest_url}")
        parsed_json = JSON.parse(response)
        render json: parsedJSON["results"]
    end

    def upcoming_movies
        upcoming_url = "https://api.themoviedb.org/3/movie/upcoming?api_key=#{MUVI_API_KEY}&language=en-US&page=1"
        response = RestClient.get("#{upcoming_url}")
        parsed_json = JSON.parse(response)
        render json: parsedJSON["results"]
    end

    def popular_movies
        popular_url = "https://api.themoviedb.org/3/movie/popular?api_key=#{MUVI_API_KEY}&language=en-US&page=1"
        response = RestClient.get("#{popular_url}")
        parsed_json = JSON.parse(response)
        render json: parsedJSON["results"]
    end

    def top_rated_movies
        top_rated_url = "https://api.themoviedb.org/3/movie/top_rated?api_key=#{MUVI_API_KEY}&language=en-US&page=1"
        response = RestClient.get("#{top_ratedr_url}")
        parsed_json = JSON.parse(response)
        render json: parsedJSON["results"]
    end
end
