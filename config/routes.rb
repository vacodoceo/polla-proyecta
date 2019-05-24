Rails.application.routes.draw do
  get 'transactions/index'
  get 'transactions/show'
  get 'transactions/new'
  get 'transactions/edit'
  get 'sessions/destroy'
  get 'home/show'
  get 'register', to: 'users#new', as: 'register'
  get 'crear_pago', to: 'transactions#crear_pago_polla', as:'crear_pago' 
  get 'bancos_posibles', to: 'transactions#bancos_posibles', as:'bancos_posibles'
  get 'estado_pago', to: 'transactions#revisar_estado_pago', as: 'revisar_pago' 

  #Google Auth
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'login', to: 'sessions#create', as: 'login'
  get 'pagar_polla', to: 'pollas#pagar_polla', as: 'pagar_polla'

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
