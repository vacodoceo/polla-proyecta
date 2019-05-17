Rails.application.routes.draw do
  get 'transactions/index'
  get 'transactions/show'
  get 'transactions/new'
  get 'transactions/edit'
  get 'pollas/index' =>'pollas#index'
  get 'pollas/show' => 'pollas#show'
  get 'pollas/new' => 'pollas#create'
  get 'pollas/edit' => 'pollas#update'
  get 'matches/index' => 'matches#index'
  get 'matches/show'
  get 'matches/new' => 'matches#create'
  get 'matches/edit' => 'matches#update'
  get 'bets/index' => 'bets#index'
  get 'bets/show'
  get 'bets/new' => 'bets#create'
  get 'bets/edit' => 'bets#update'
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

  root to: "home#show"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
