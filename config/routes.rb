Rails.application.routes.draw do
  root 'books#viewer_index'
  get 'to_use',                   to: 'tops#show'
  get    '/login',                to: 'sessions#new'
  post   '/login',                to: 'sessions#create'
  delete '/logout',               to: 'sessions#destroy'
  get 'books/posts',              to: 'books#posts_index'
  get 'books/viewer',             to: 'books#viewer_index'
  post 'favorites',               to: 'favorites#create'
  delete 'unfavorites',           to: 'favorites#destroy'
  get 'favorites/show',           to: 'favorites#show'
  get 'picture_show',             to: 'volumes#picture_position_show'
  get 'pictures_show',            to: 'volumes#picture_show'
  get '/auth/:provider/callback', to: 'users#google_login',      as: :auth_google_callback
  get '/auth/:provider/callback', to: 'users#facebook_login',      as: :auth_facebook_callback
  get '/auth/failure',            to: 'users#auth_failure', as: :auth_failure
  
  resources :users
  resources :books
  resources :volumes do
      member do
        get :change_position
        get :picture_show_chenge
    end
  end
  resources :evaluations
end
