class Api::V1::UsersController < ApplicationController
    # skip_before_action :authenticate_user, only: [:allInfo, :info, :create, :edit]
    # skip_before_action :authenticate_user, only: [:create]
  before_action :authenticate_user, only: [:show, :info, :create, :edit]

    # def index
    #     @users = User.all
    #     if @users
    #         render json: UserSerializer.new(users)
    #         render json: {users: @users, except: [:password, :password_digest]}
    #     else
    #         render json: {status: 500, errors: ['No User Found']}
    #     end
    # end

    # def new
    #     @user = User.new
    # end

  def profile
    render json: { user: UserSerializer.new(current_user) }, status: :accepted
  end

  def show # allInfo
    @user = User.find(@user.id)
    # render json: { savedMovies: user.movies }
    if @user
        render json: { savedMovies: user.movies }
    else
        render json: { error: 'ERROR: No User Datat' }, status: :not_acceptable
    end
  end

  def info
    profile = User.find(params[:id])
    # byebug
    # render json: { user_info: profile, savedMovies: profile.movies, comments: profile.comments }
    if profile
      render json: { user_info: profile, savedMovies: profile.movies, comments: profile.comments}
      # render json: @user, include: [:movies]
    else
      render json: { error: 'ERROR: No User Data' }, status: :not_acceptable
    end
  end

  def create
    # @user = User.create(user_params)
    # if @user.valid?
    #     session[:user_id] = @user.id
    #     render json: UserSerializer.new(@user), status: created
    #     # render json: {user: @user, except: [:password, :password_digest], status: :created}
    # else
    #     render json: {error: 'ERROR: Failed to create User'}, status: :not_acceptable
    # end
    @user = User.create(user_params)
    # byebug

    if @user.valid?
      # @token = encode_token(user_id: @user.id)
      # render json: { user: @user, jwt: @token }, status: :created
      # render json: { user: @user, jwt: encode_toke(user_id: @user.id)}, status: :created
      render json: { user: UserSerializer.new(@user), jwt: encode_token(user_id: @user.id)}, status: :created
    else
      render json: { error: 'ERROR: Failed to create User' }, status: :not_acceptable
    end
  end

  def edit
    user = User.find(@user.id)
    if params[:password] == "" then
      user.update(username: params[:user][:username],
        about: params[:user][:about],
        picture_profile: params[:user][:picture_profile])
    else
      user.update(user_params)
    end
      render json: user.to_json
  end

  private
    def user_params
      params.require(:user).permit(:username, :password, :about, :profile_picture)
    end
end
