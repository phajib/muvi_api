class Api::V1::MoviesController < ApplicationController
  require 'rest-client'
  # https://medium.com/@cristicristo/using-the-rest-client-gem-to-seed-data-in-rails-b37bdc0e5d1
  # Use above link to get data from TMDB API using rest-client

  skip_before_action :authenticate_user, only: [:all_movies, :movie_details, :latest_movies, :upcoming_movies, :popular_movies, :top_rated_movies, :search]

  MUVI_API_KEY = ENV['TMDB_API_KEY']


  def all_movies #index
    movies = Movie.all
    # render json: movies.to_json(serialized_data)
    render json: movies.to_json(include: {
                                  genres: { except: %i[created_at updated_at] },
                                  except: %i[created_at updated_at]
                                })
  end

  def movie_details
    tmdb_id = params[:id]
    movie_details_url = "https://api.themoviedb.org/3/movie/#{tmdb_id}?api_key=#{MUVI_API_KEY}&language=en-US"
    render json: JSON.parse(RestClient.get("#{movie_details_url}"))
  end

  def latest_movies
    latest_url = "https://api.themoviedb.org/3/movie/latest?api_key=#{MUVI_API_KEY}&language=en-US"
    render json: JSON.parse(RestClient.get("#{latest_url}"))["results"]
  end

  def upcoming_movies
    upcoming_url = "https://api.themoviedb.org/3/movie/upcoming?api_key=#{MUVI_API_KEY}&language=en-US"
    parsed_json = JSON.parse(RestClient.get("#{upcoming_url}".to_s))
    render json: parsed_json['results']
  end

  def popular_movies
    page = params['page']
    popular_url = "https://api.themoviedb.org/3/movie/popular?api_key=#{MUVI_API_KEY}&language=en-US&page=#{page}"
    parsed_json = JSON.parse(RestClient.get("#{popular_url}".to_s))
    render json: parsed_json['results']
  end

  def top_rated_movies
    top_rated_page = params['page']
    top_rated_url = "https://api.themoviedb.org/3/movie/top_rated?api_key=#{MUVI_API_KEY}&language=en-US&page=#{top_rated_page}"
    parsed_json = JSON.parse(RestClient.get("#{top_rated_url}".to_s))
    render json: parsed_json['results']
  end

  def search
    search_query = params[:title]
    search_url = "https://api.themoviedb.org/3/search/movie?api_key=#{MUVI_API_KEY}&language=en-US&query=#{search_query}"
    parsed_json = JSON.parse(RestClient.get("#{search_url}"))
    render json: parsed_json
  end

  private
    def serialized_data
        {
          :include => {
              :genres => 
              {:except => [:created_at, :updated_at]}
          },
          :except => [:created_at, :updated_at]
        }
    end
end
