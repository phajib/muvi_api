class Api::V1::AuthController < ApplicationController
    skip_before_action :authenticate_user, only: [:create]

    def create
        @user = User.find_by(username: login_params[:username])
        #User#authenticate comes from BCrypt
        if @user && @user.authenticate(login_params[:password])
          # encode token comes from ApplicationController
          token = encode_token({ user_id: @user.id })
          render json: { user: UserSerializer.new(@user), jwt: token }, status: :accepted
        else
          render json: { message: 'Username or Password is INVALID' }, status: :unauthorized
        end
    end

    private
      def login_params
        params.require(:user).permit(:username, :password)
      end
end
