Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post 'login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

  resources :users
  resources :conversations, only: [:index, :show]
  resources :messages, only: [:create]
end
