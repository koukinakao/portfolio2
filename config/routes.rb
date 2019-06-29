Rails.application.routes.draw do
  root 'books#viewer_index'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get 'books/posts', to: 'books#posts_index'
  get 'books/viewer', to: 'books#viewer_index'
  post 'favorites', to: 'favorites#create'
  delete 'unfavorites', to: 'favorites#destroy'
  get 'picture_show', to: 'volumes#picture_position_show'
  get 'pictures_show', to: 'volumes#picture_show'
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
