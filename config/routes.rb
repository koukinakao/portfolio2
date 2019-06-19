Rails.application.routes.draw do
  root 'tops#show'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get 'books/posts', to: 'books#posts_index'
  get 'books/viewer', to: 'books#viewer_index'
  resources :users
  resources :books
  resources :volumes do
    resources :pictures
  end
end
