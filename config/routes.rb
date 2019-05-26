Rails.application.routes.draw do
  resources :first_rounds
  get 'transactions/index'
  get 'transactions/show'
  get 'transactions/new'
  get 'transactions/edit'
  get 'sessions/destroy'
  get 'home/show'
  get 'register', to: 'users#new', as: 'register'
  get 'crear_pago/:id', to: 'pollas#crear_pago_polla', as:'crear_pago' 
  get 'bancos_posibles', to: 'transactions#bancos_posibles', as:'bancos_posibles'
  get 'estado_pago/:id', to: 'transactions#revisar_estado_pago', as: 'revisar_pago' 
  get 'validar_polla/:id', to: 'pollas#validar_polla', as: 'validar_polla'
  get 'invalidar_polla/:id', to: 'pollas#invalidar_polla', as: 'invalidar_polla'
  get 'validar_pagos', to: 'transactions#validar_pagos', as: 'validar_pagos'
  get 'ranking', to: 'home#ranking', as:'ranking'
  get 'create_user', to: 'users#create', as: 'create_user'
  #Google Auth
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  #get 'signout', to: 'sessions#destroy', as: 'signout'
  #get 'login', to: 'sessions#create', as: 'login'

  resources :sessions
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'login', to: 'sessions#new', as: 'login'
  get 'create_normal_session', to: 'sessions#create_normal', as: 'create_normal_session'

  resource :home, only: [:show]
  resources :users
  resources :pollas
  resources :matches
  resources :bets
  resources :transactions

  root to: "home#show"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
