class UserMoviesController < ApplicationController
    before_action :authorized, only: [:create, :index]

    def index #all
        users_id = request.headers["User"]
        find_user = User.find(users_id)
        users_movies = find_user.movies
        render json: users_movies
    end

    def create
        movieID = 0
        params[:movie][:tmdb_id] ? movieID = params[:movie][:tmdb_id] : movieID = params[:movie][:id]
        user = User.find_by(username: params[:user][:username])

        if !Movie.find_by(tmdb_id: id)
            @add_movie = Movie.create_or_find_by(  #create_or_find_by! Will raise if validation error
                popularity: params[:movie]["popularity"],
                vote_count: params[:movie]["vote_count"],
                video: params[:movie]["video"],
                poster_path: params[:movie]["poster_path"],
                homepage: params[:movie]["homepage"],
                tmdb_id: params[:movie]["tmdb_id"],
                imdb_id: params[:movie]["imdb_id"],
                backdrop_path: params[:movie]["backdrop_path"],
                original_title: params[:movie]["original_title"],
                vote_average: params[:movie]["vote_average"],
                overview: params[:movie]["overview"],
                release_date: params[:movie]["release_date"],
                runtime: params[:movie]["runtime"]
            )
            render json: UserMovies.create(user_id: user.id, movie_id: @add_movie.id).movie
        else
            movieID = Movie.where(tmdb_id: id)[0].id
            # movieID = Movie.find(tmdb_id: id)
            if !user.user_movies.where(movie_id: movieID).length > 0
                render json: UserMovies.create(user_id: user.id, movie_id: movieID).movie
            else
                render json: {message: 'Movie exists in your list!'}
            end
        end
    end
end
