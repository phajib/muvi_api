class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.float :popularity
      t.integer :vote_count
      t.boolean :video
      t.string :poster_path
      t.string :homepage
      t.integer :tmdb_id
      t.integer :imdb_id
      t.string :backdrop_path
      t.string :original_title
      t.integer :movie_genre
      t.float :vote_average
      t.string :overview
      t.integer :release_date
      t.integer :runtime
      t.string :tagline

      t.timestamps
    end
  end
end
