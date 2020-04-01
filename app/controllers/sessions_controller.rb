class SessionsController < ApplicationController
    # def new
      # user = User.new
    # end

    def create
      # if current_user
      #   redirect_to '/'
      # else
        @user = User.find_by(username: login_params[:username])
        if @user && @user.authenticate(login_params[:password])
          session[:current_user_id] = @user.id
          # sessions[:user_id] = @user.id
          # render json: @user, status: 200
          # render json: UserSerializer.new(@user), status: 200
          render json: { user: @user, except: [:passowrd, :password_digest] }
        else
          render json: { message: 'Invalid username or password' }, status: :unauthorized
          # redirect_to '/login'
        end
      # end
    end

    def destroy
      reset_session
      # session.clear
      # redirect_to '/login'
      render json: { message: "Successfully logged out"}, status: 200
    end

    private
      def login_params
        params.require(:user).permit(:username, :password)
      end

end
