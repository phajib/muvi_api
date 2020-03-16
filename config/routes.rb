Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]

      get '/profile' => 'users#index'
      
      get '/movies' => 'movies#all_movies'
      get '/movie/:id' => 'movies#movie_details'
      get '/latest' => 'movies#latest_movies'
      get '/upcoming' => 'movies#upcoming_movies'
      get '/popular/:page' => 'movies#popular_movies'
      get '/top_rated' => 'movies#top_rated_movies'
    
      get '/usermovies', to: 'user_movies#index'
      post '/usermovies', to: 'user_movies#create'
    
      get '/comments', to: 'comment#index'
      get '/comments/movie/:tmdb_id', to: 'comment#movie'
      post '/comments', to: 'comment#create'
      delete '/comments/:id', to: 'comment#destroy'
    end
  end


  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
# namespace :api do
#   namespace :v1 do
    # resources :movies
    # resources :user_movies
    # resources :comments
#   end
# end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
