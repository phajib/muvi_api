class Api::V1::UserMoviesController < ApplicationController
  before_action :authenticate_user, only: [:create, :index]

  def index
    users_id = request.headers["User"]
    find_user = User.find(users_id)
    users_movies = find_user.movies
    render json: users_movies
  end

  def create
    if Movie.find_by(tmdb_id: params[:movie][:id])
      movie_ID = Movie.where(tmdb_id: params[:movie][:id])[0].id
      if @user.user_movies.where(movie_id: movie_ID).length > 0
        render json: { message: 'You have this movie already!' }
      else
        render json: UserMovie.create(user_id: @user.id, movie_id: movie_ID).movie
      end
    else
      @add_movie = Movie.create_or_find_by(  #create_or_find_by! Will raise if validation error
        popularity: params[:movie]['popularity'],
        vote_count: params[:movie]['vote_count'],
        video: params[:movie]['video'],
        poster_path: params[:movie]['poster_path'],
        homepage: params[:movie]['homepage'],
        tmdb_id: params[:movie]['id'],
        imdb_id: params[:movie]['imdb_id'],
        backdrop_path: params[:movie]['backdrop_path'],
        original_title: params[:movie]['original_title'],
        vote_average: params[:movie]['vote_average'],
        overview: params[:movie]['overview'],
        release_date: params[:movie]['release_date'],
        runtime: params[:movie]['runtime'],
        tagline: params[:movie]['tagline']
      )
      render json: UserMovie.create(user_id: @user.id, movie_id: @add_movie.id).movie
    end
  end
end
