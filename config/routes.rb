Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      
      post '/login' => 'auth#create'

      get '/profile' => 'users#profile'
      # get '/userprofile' => 'users#profile'
      # get '/user' => 'users#show'
      
      get '/movies' => 'movies#all_movies'
      get '/movie/:id' => 'movies#movie_details'
      get '/latest' => 'movies#latest_movies'
      get '/upcoming' => 'movies#upcoming_movies'
      get '/popular/:page' => 'movies#popular_movies'
      get '/top_rated' => 'movies#top_rated_movies'
      get '/search/:orignal_title' => 'movies#search'
    
      get '/usermovies', to: 'user_movies#index'
      post '/usermovies', to: 'user_movies#create'
    
      get '/comments', to: 'comments#index'
      get '/comments/movie/:tmdb_id', to: 'comment#movie'
      post '/comments', to: 'comments#create'
      delete '/comments/:id', to: 'comments#destroy'
    end
  end

  # get '/login' => 'sessions#new'
  # post '/login' => 'sessions#create'
  # post '/logout' => 'sessions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
