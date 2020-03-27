class Api::V1::UsersController < ApplicationController
    skip_before_action :authenticate_user, only: [:allInfo, :info, :create, :edit]

    # def index
    #     users = User.all
    #     render json: UserSerializer.new(users)
    # end

    # def new
    #     @user = User.new
    # end

    def profile
        render json: { user: UserSerializer.new(current_user) }, status: :accepted
    end

    def allInfo 
        user = User.find(@user.id)
        if user
            render json: {userMovies: user.movies}
        else
            render json: {error: 'ERROR: No User Datat' }, status: :not_acceptable
        end
    end

    def info 
        profile = User.find(params[:id])
        if profile
            render json: {user_info: profile, userMovies: profile.games, comments: profile.comments}
            # render json: @user#, include: [:movies]   
        else
            render json: { error: 'ERROR: No User Data' }, status: :not_acceptable
        end
    end

    def create
        @user = User.create(user_params)
        if @user.valid?
            @token = encode_token(user_id: @user.id)
            render json: { user: @user, jwt: @token }, status: :created
            # session[:current_user_id] = @user.id
            # render json: @user, status: :created
        else
            render json: { error: 'ERROR: Failed to create User' }, status: :not_acceptable
            # render :new
        end
    end
    
    def edit
        user = User.find(@user.id)
        if params[:password] == "" then
            user.update(username: params[:user][:username], about: params[:user][:about], picture_profile: params[:user][:picture_profile])
        else 
            user.update(user_params)
        end

        render json: user.to_json
    end

    # def show
    #     @user = User.find(params[:id])
    #     render json: @user#, include: [:movies]
    # end

    private
        def user_params
            params.require(:user).permit(:username, :password, :about, :profile_picture)
        end
end
