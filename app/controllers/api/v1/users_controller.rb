class Api::V1::UsersController < ApplicationController
    skip_before_action :authenticate_user, only: [:create]

    # def index
    #     users = User.all
    #     render json: UserSerializer.new(users)
    # end

    # def new
    #     @user = User.new
    # end

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
    
    # def show
    #     @user = User.find(params[:id])
    #     render json: @user#, include: [:movies]
    # end

    def profile
        render json: { user: UserSerializer.new(current_user) }, status: :accepted
    end

    private
        def user_params
            params.require(:user).permit(:username, :password, :about, :profile_picture)
        end
end
