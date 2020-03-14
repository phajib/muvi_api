class MovieGenre < ApplicationRecord
    has_many :movie_genres
    has_many :movies, through: :movie_genres
end
