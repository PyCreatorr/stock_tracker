Rails.application.routes.draw do
  resources :user_stocks, only: [:create]
  # get 'users/my_data'
  devise_for :users
  root "welcome#index"

  get 'my_data', to: 'users#my_data'
  
  get 'search_stock', to: 'stocks#search'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
