class Api::V1::AuthController < ApplicationController
    skip_before_action :authenticate_user, only: [:create]

    def create
      # @user = User.find_by(params[:username])
      @user = User.find_by(username: login_params[:username])
      # byebug
        #authenticate comes from BCrypt
        if @user && @user.authenticate(login_params[:password])
          # encode token comes from ApplicationController
          # token = encode_token({ user_id: @user.id })
          # render json: { user: UserSerializer.new(@user), jwt: token }, status: :accepted
          render json: { user: UserSerializer.new(@user), jwt: encode_token({user_id: @user.id}) }, status: :accepted
        else
          # render json: { status: 401, errors: ['User Not Found', 'Verify Credentials and Try Again or Signup'] }
          render json: { message: 'Invalid username or password' }, status: :unauthorized
        end
    end

    private
      def login_params
        params.require(:user).permit(:username, :password)
      end
end
