class MovieSerializer < ActiveModel::Serializer
  attributes :id, :popularity, :vote_count, :video, :poster_path, :homepage, :tmdb_id, :imdb_id, :backdrop_path, :original_title, :movie_genre, :vote_average, :overview, :release_date, :runtime
end
