class Api::V1::UserMoviesController < ApplicationController
    before_action :authenticate_user, only: [:create, :index]

    def index
        users_id = request.headers["User"]
        find_user = User.find(users_id)
        users_movies = find_user.movies
        render json: users_movies
    end

    def create
        # byebug
        id = 0
        params[:movie][:id] ? id = params[:movie][:id] : id = params[:movie][:tmdb_id]
        user = User.find_by(user_id: params[:user][:id])

        if !Movie.find_by(tmdb_id: id)
          @add_movie = Movie.create_or_find_by(  #create_or_find_by! Will raise if validation error
            title: params[:movie]["title"],
            original_title: params[:movie]["original_title"],
            poster_path: params[:movie]["poster_path"],
            tmdb_id: params[:movie]["id"],
            imdb_id: params[:movie]["imdb_id"],
            overview: params[:movie]["overview"],
            backdrop_path: params[:movie]["backdrop_path"],
            popularity: params[:movie]["popularity"],
            runtime: params[:movie]["runtime"],
            release_date: params[:movie]["release_date"],
            video: params[:movie]["video"],
            tagline: params[:movie]["tagline"],
            vote_count: params[:movie]["vote_count"],
            vote_average: params[:movie]["vote_average"],
            homepage: params[:movie]["homepage"]
          )
          render json: UserMovies.create(user_id: user.id, movie_id: @add_movie.id).movie
        else
          movie_ID = Movie.where(tmdb_id: id)[0].id
          if user.user_movies.where(movie_id: movie_ID).length > 0
            render json: { message: 'You have saved this movie already!' }
          else
            render json: UserMovies.create(user_id: user.id, movie_id: movie_ID).movie
          end
        end
    end
end
