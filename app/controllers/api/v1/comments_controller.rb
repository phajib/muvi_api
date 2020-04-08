class Api::V1::CommentsController < ApplicationController
    before_action :authorized, only: [:create, :destroy]

  def movie
    byebug
    movieID = Movie.all.find_by(tmdb_id: params[:id])
    render json: movieID.comments
  end

  def index
    comments = Comment.all
    render json: comments
  end

  def create
    movie = params["movie"]
    content = params["content"]

    if movie["movie_id"]
      render json: Comment.create(comments_params)
    else
      movie = Movie.find_by(movie_id: movie['id'])
        # if Movie.find_by(tmdb_id: movie["id"])
        if movie
          render json: Comment.create(comments_params)
        else
          create_movie = Movie.create_or_find_by(
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
            render json: Comment.create(comments_params)
        end
    end
  end

  def destroy
    render json: Comment.destroy(params[:id])
  end

  private
  def comments_params
      params.require(:comment).permit(:user_id, :movie_id, :content, :original_title)
  end
end
