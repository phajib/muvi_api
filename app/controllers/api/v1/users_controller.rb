class Api::V1::UsersController < ApplicationController
    def index
        users = User.all
        render json: UserSerializer.new(users)
    end

    def new
        @user = User.new
    end

    def create
        @user = User.create(user_params)
        if @user.valid?
            session[:current_user_id] = @user.id
            render json: @user, status: :created
        else
            render :new
            render json: { error: 'ERROR: Failed to create User' }, status: :unprocessable_entity
        end
    end
    
    def show
        @user = User.find(params[:id])
        render json: @user#, include: [:movies]
    end

    private
        def user_params
            params.require(:user).permit(:username, :password, :about, :profile_picture)
        end
end
