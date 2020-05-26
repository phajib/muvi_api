class Api::V1::MoviesController < ApplicationController
  require 'rest-client'
  # https://medium.com/@cristicristo/using-the-rest-client-gem-to-seed-data-in-rails-b37bdc0e5d1
  # Use above link to get data from TMDB API using rest-client

  skip_before_action :authenticate_user, only: [:all_movies, :movie_details, :latest_movies, :upcoming_movies, :popular_movies, :top_rated_movies, :recommendations_movies, :search]

  MUVI_API_KEY = ENV['TMDB_API_KEY']
  TMDB_ADDRESS = "https://api.themoviedb.org/3"


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
    movie_details_url = "#{TMDB_ADDRESS}/movie/#{tmdb_id}?api_key=#{MUVI_API_KEY}&language=en-US&append_to_response=videos"
    render json: JSON.parse(RestClient.get("#{movie_details_url}"))
  end

  # def latest_movies
  #   latest_url = "#{TMDB_ADDRESS}/movie/latest?api_key=#{MUVI_API_KEY}&language=en-US"
  #   parsed_json = JSON.parse(RestClient.get("#{latest_url}".to_s))
  #   render json: parsed_json['results']
  # end

  def upcoming_movies
    upcoming_url = "#{TMDB_ADDRESS}/movie/upcoming?api_key=#{MUVI_API_KEY}&language=en-US"
    parsed_json = JSON.parse(RestClient.get("#{upcoming_url}".to_s))
    render json: parsed_json['results']
  end

  def popular_movies
    page = params['page']
    popular_url = "#{TMDB_ADDRESS}/movie/popular?api_key=#{MUVI_API_KEY}&language=en-US&page=#{page}"
    parsed_json = JSON.parse(RestClient.get("#{popular_url}".to_s))
    render json: parsed_json['results']
  end

  def top_rated_movies
    top_rated_page = params['page']
    top_rated_url = "#{TMDB_ADDRESS}/movie/top_rated?api_key=#{MUVI_API_KEY}&language=en-US&page=#{top_rated_page}"
    parsed_json = JSON.parse(RestClient.get("#{top_rated_url}".to_s))
    render json: parsed_json['results']
  end

  # def recommendations_movies
  #   tmdb_id = params[:id]
  #   recommendations_url = "#{TMDB_ADDRESS}/#{tmdb_id}/recommendations?api_key=#{MUVI_API_KEY}&language=en-US"
  #   parsed_json = JSON.parse(RestClient.get("#{recommendations_url}".to_s))
  #   render json: parsed_json['results']
  # end

  def recommendations_movies
    tmdb_id = params[:id]
    recommendations_url = "#{TMDB_ADDRESS}/movie/#{tmdb_id}?api_key=#{MUVI_API_KEY}&language=en-US&append_to_response=recommendations"
    parsed_json = JSON.parse(RestClient.get("#{recommendations_url}".to_s))
    render json: parsed_json['results']
  end

  def search
    search_query = params[:title]
    search_url = "#{TMDB_ADDRESS}/search/movie?api_key=#{MUVI_API_KEY}&language=en-US&query=#{search_query}"
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
