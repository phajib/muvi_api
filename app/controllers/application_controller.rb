class ApplicationController < ActionController::API
  before_action :authenticate_user

  def index
    render :login
  end

  def current_user
    # @logged_in_user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def authenticate_user
    render json: { message: 'Please Log In to continue' }, status: :unauthorized unless logged_in?
    # redirect_to root_path unless logged_in?
  end
end
