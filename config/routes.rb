Rails.application.routes.draw do
  
  root to: 'toppages#index'
  get 'signup',to: 'users#new'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users,only: [:edit,:create,:update]
  resources :tasks,only: [:update,:edit,:create,:destroy]
  resources :posts,only: [:create,:destroy]
  resources :memos,only: [:update,:edit,:create,:destroy]
  
end
