Rails.application.routes.draw do
namespace :api do
  namespace :v1 do
    resources :users
    get '/login' => 'sessions#new'
    post '/login' => 'sessions#create'
    post '/logout' => 'sessions#destroy'
    get '/profile' => 'users#index'

  end
end


  # resources :comments
  # resources :movie_genres
  # resources :genres
  # resources :movies
  # resources :user_movies
  # resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
