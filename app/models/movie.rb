class Movie < ApplicationRecord
  has_many :user_movies
  has_many :users, through: :user_movies
  has_many :movie_genres
  has_many :genres, through: :movie_genres
  has_many :comments

  require 'rest-client'
  
  MUVI_API_KEY = ENV['TMDB_API_KEY']

  def self.seed
     # SEEDING WITH LATEST MOVIES & GENRES
    latest_movies_url = "https://api.themoviedb.org/3/movie/latest?api_key=#{MUVI_API_KEY}&language=en-US"
    # Using rest-client for GET request
    latest = JSON.parse(RestClient.get(latest_movies_url))

    # Movie Details from latest_movie_url
    latest['results'].each do |movie|
      movie_details_url = "https://api.themoviedb.org/3/movie/#{movie['id']}?api_key=#{MUVI_API_KEY}&language=en-US"
      movie_details = JSON.parse(RestClient.get(movie_details_url))

      # Create Movie
      Movie.create_or_find_by(
        popularity: movie_details[:movie]['popularity'],
        vote_count: movie_details[:movie]['vote_count'],
        video: movie_details[:movie]['video'],
        poster_path: movie_details[:movie]['poster_path'],
        homepage: movie_details[:movie]['homepage'],
        tmdb_id: movie_details[:movie]['tmdb_id'],
        imdb_id: movie_details[:movie]['imdb_id'],
        backdrop_path: movie_details[:movie]['backdrop_path'],
        original_title: movie_details[:movie]['original_title'],
        vote_average: movie_details[:movie]['vote_average'],
        overview: movie_details[:movie]['overview'],
        release_date: movie_details[:movie]['release_date'],
        runtime: movie_details[:movie]['runtime']
      )

      # taking care of creating the genres
      movie_details['genres'].each do |genre|
        mov = Movie.find_by(tmdb_id: movie['id'])
        gen = Genre.find_by(genre_api_id: genre['id'])
        # create Genre
        MovieGenres.create_or_find_by(movie_id: mov.id, genre_id: gen.id)
      end
    end
  end
end
