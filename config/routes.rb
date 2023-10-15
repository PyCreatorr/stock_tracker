Rails.application.routes.draw do
  
  resources :friendships, only: [:create]  
  # post 'friendships', to: 'friendships#create'
  delete 'friendships', to: 'friendships#destroy'
  get 'my_friends', to: 'users#my_friends'
  get 'search_friend', to: 'users#search'

  resources :user_stocks, only: [:create]

  # get 'users/:id', to: 'users#show'

  
  delete 'user_stocks', to: 'user_stocks#destroy'
  # get 'users/my_data'
  devise_for :users
  root "welcome#index"
  
  resources :users, only: [:show]
  
  get 'my_data', to: 'users#my_data'
  
  get 'search_stock', to: 'stocks#search'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
