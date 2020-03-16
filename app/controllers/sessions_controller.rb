class SessionsController < ApplicationController
    def new
      # user = User.new
    end

    def create
      if current_user
        redirect_to '/'
      else
        @user = User.find_by(username: params[:username])
        if @user && @user.password == params[:password]
          session[:current_user_id] = @user.id
          # render json: @user, status: 200
          render json: UserSerializer.new(@user), status: 200
        else
          redirect_to '/login'
        end
      end
    end

    def destroy
      reset_session
      # session.clear
      redirect_to '/login'
      # render json: {
      #   message: "Successfully logged out"
      #   }, status: 200
      # end
    end

end
