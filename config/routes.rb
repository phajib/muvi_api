Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      post '/login' => 'auth#create'
      # post '/login' => 'sessions#create'
      delete '/logout' => 'sessions#destroy'
      
      get '/user/all_info' => 'users#show'
      get '/user/:id/info' => 'users#info'
      get '/profile' => 'users#profile'
      patch '/user/edit' => "users#edit"

      # get '/userprofile' => 'users#profile'
      # get '/user' => 'users#show'

      get '/movies' => 'movies#all_movies'
      get '/movie/:id' => 'movies#movie_details'
      get '/latest' => 'movies#latest_movies'
      get '/upcoming' => 'movies#upcoming_movies'
      get '/popular/:page' => 'movies#popular_movies'
      get '/top_rated' => 'movies#top_rated_movies'
      get '/search/:title' => 'movies#search'
      
      get '/usermovies' => 'user_movies#index'
      post '/usermovies' => 'user_movies#create'

      get '/comments' => 'comments#index'
      get '/comments/movie/:movieID' => 'comments#movie'
      post '/comments' => 'comments#create'
      delete '/comments/:id' => 'comments#destroy'
    end
  end

  # get '/login' => 'sessions#new'
  # post '/login' => 'sessions#create'
  # post '/logout' => 'sessions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
