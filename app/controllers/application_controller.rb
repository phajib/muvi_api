class ApplicationController < ActionController::API
  before_action :authenticate_user

  def encode_token(payload)
    JWT.encode(payload, 'mine')
  end

  def auth_header
      # { Authorization: 'Bearer <token>' }
      request.headers['Authorization']
  end

  def decoded_token
      if auth_header
        token = auth_header.split(' ')[1]
        begin
          JWT.decode(token, 'mine', true, algorithm: 'HS256')
        rescue JWT::DecodeError
          nil
        end
      end
  end

  def current_user
    # @current_user ||= User.find(session[:user_id]) if session[:user_id]
      if decoded_token
          user_id = decoded_token[0]['user_id']
          @user = User.find_by(id: user_id)
      end
  end

  def logged_in?
      !!current_user
  end

  def authenticate_user
      render json: { message: 'You Must Log In' }, status: :unauthorized unless logged_in?
  end
end
