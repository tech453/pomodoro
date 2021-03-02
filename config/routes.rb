Rails.application.routes.draw do
  
  root to: 'toppages#index'
  
  get 'start',to: 'toppages#start'
  get 'stop',to: 'toppages#stop'
  
  get 'signup',to: 'users#new'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'task_and_memo', to: 'toppages#task_and_memo'
  get 'posts', to: 'toppages#post'
  
  get 'all_post', to: 'toppages#all_post'
  get 'my_post', to: 'toppages#my_post'
  
  resources :users,only: [:edit,:create,:update]
  resources :tasks,only: [:update,:edit,:create,:destroy]
  resources :posts,only: [:create,:destroy]
  resources :memos,only: [:update,:edit,:create,:destroy]
  
end
