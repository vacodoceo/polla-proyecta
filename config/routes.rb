Rails.application.routes.draw do
  get 'transactions/index'
  get 'transactions/show'
  get 'transactions/new'
  get 'transactions/edit'
  get 'pollas/index'
  get 'pollas/show'
  get 'pollas/new'
  get 'pollas/edit'
  get 'matches/index'
  get 'matches/show'
  get 'matches/new'
  get 'matches/edit'
  get 'bets/index'
  get 'bets/show'
  get 'bets/new'
  get 'bets/edit'
  get 'sessions/create'
  get 'sessions/destroy'
  get 'home/show'

  #Google Auth
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'login', to: 'sessions#new', as: 'login'

  resources :sessions, only: [:create, :new, :destroy]
  resource :home, only: [:show]
  resource :user

  root to: "home#show"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
