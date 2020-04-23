class Api::V1::CommentsController < ApplicationController
    before_action :authenticate_user, only: [:create, :destroy]

  def movie
    movie_found = Movie.find_by(tmdb_id: params[:id])
    # render json: movie_found.comments
    if movie_found
      if movie_found.comments.count == 0
        render json: { message: "No Comments for this Movie" }
      else
        render json: { comments: movie_found.comments }
      end
    else
      render json: { message: "Movie not found" }
    end
  end

  def index
    comment = Comment.all
    render json: comment
  end

  def show
    render json: current_user.comments.reverse
  end

  def create
    movie = params[:movie]
    content = params[:content]
    if movie[:tmdb_id]
      # render json: Comment.create(comments_params)
      render json: Comment.create({
        user_id: current_user.id,
        movie_id: movie[:id],
        content: content,
        movie_title: movie[:orginal_title],
        profile_picture: current_user[:profile_picture],
        username: current_user[:username]
        })
    else
      movie = Movie.find_by(tmdb_id: movie[:id])

      if movie
        render json: Comment.create({
          user_id: current_user.id,
          movie_id: movie[:id],
          content: content,
          movie_title: movie[:original_title],
          profile_picture: current_user[:profile_picture],
          username: current_user[:username]
        })
      else
        create_movie = Movie.create_or_find_by(
          popularity: params[:movie]['popularity'],
          vote_count: params[:movie]['vote_count'],
          video: params[:movie]['video'],
          poster_path: params[:movie]['poster_path'],
          homepage: params[:movie]['homepage'],
          tmdb_id: params[:movie]['tmdb_id'],
          imdb_id: params[:movie]['imdb_id'],
          backdrop_path: params[:movie]['backdrop_path'],
          original_title: params[:movie]['original_title'],
          vote_average: params[:movie]['vote_average'],
          overview: params[:movie]['overview'],
          release_date: params[:movie]['release_date'],
          runtime: params[:movie]['runtime'],
          tagline: params[:movie]['tagline'],
          id: params[:movie][:id]
        )
        render json: Comment.create({
          user_id: current_user.id,
          movie_id: params[:movie][:id],
          content: content,
          movie_title: params[:movie][:original_title],
          profile_picture: current_user[:profile_picture],
          username: current_user[:username]
        })
      end
    end
  end

  def destroy
    comment = Comment.find(params[:id]).destroy
    render json: comment
    # render json: Comment.destroy(params[:id])
  end
end
