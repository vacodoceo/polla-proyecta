Rails.application.routes.draw do
  get 'transactions/index'
  get 'transactions/show'
  get 'transactions/new'
  get 'transactions/edit'
  get 'sessions/destroy'
  get 'home/show'
  get 'register', to: 'users#new', as: 'register'

  #Google Auth
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'login', to: 'sessions#new', as: 'login'

  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]
  resource :user
  resources :pollas
  resources :matches
  resources :bets
  resources :transactions

  root to: "home#show"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
