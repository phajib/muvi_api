class MoviesController < ApplicationController
  require 'rest-client'

  # skip_before_action :authorized, only: %i[all_movies movie_details latest_movies upcoming_movies popular_movies top_rated_movies]

  MUVI_API_KEY = ENV['TMDB_API_KEY']

  def all_movies
    movies = Movie.all
    render json: movies.to_json(include: {
                                  genres: { except: %i[created_at updated_at] },
                                  except: %i[created_at updated_at]
                                })
  end

  def movie_details
    movie_api_id = params[:id]
    movie_details_url = "https://api.themoviedb.org/3/movie/#{movie_api_id}?api_key=#{MUVI_API_KEY}&language=en-US"
    render json: RestClient.get(movie_details_url.to_s)
  end

  def latest_movies
    latest_url = "https://api.themoviedb.org/3/movie/latest?api_key=#{MUVI_API_KEY}&language=en-US"
    parsed_json = JSON.parse(RestClient.get(latest_url.to_s))
    render json: parsed_json['results']
  end

  def upcoming_movies
    upcoming_page = 1
    upcoming_url = "https://api.themoviedb.org/3/movie/upcoming?api_key=#{MUVI_API_KEY}&language=en-US&page=#{upcoming_page}"
    parsed_json = JSON.parse(RestClient.get(upcoming_url.to_s))
    render json: parsed_json['results']
  end

  def popular_movies
    page = params['page']
    popular_url = "https://api.themoviedb.org/3/movie/popular?api_key=#{MUVI_API_KEY}&language=en-US&page=#{page}"
    parsed_json = JSON.parse(RestClient.get(popular_url.to_s))
    render json: parsed_json['results']
  end

  def top_rated_movies
    top_rated_page = 1
    top_rated_url = "https://api.themoviedb.org/3/movie/top_rated?api_key=#{MUVI_API_KEY}&language=en-US&page=#{top_rated_page}"
    parsed_json = JSON.parse(RestClient.get(top_rated_url.to_s))
    render json: parsed_json['results']
  end
end
