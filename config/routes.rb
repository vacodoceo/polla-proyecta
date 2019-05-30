Rails.application.routes.draw do
  resources :results
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
  get 'pollas_totales', to: 'pollas#pollas_totales', as: "pollas_totales"
  get 'validar_pagos', to: 'pollas#validar_pagos', as: 'validar_pagos'
  get 'ranking', to: 'home#ranking', as:'ranking'
  get 'faqs', to: 'home#faqs', as:'faqs'
  get 'rules', to: 'home#rules', as:'rules'
  get 'create_user', to: 'users#create', as: 'create_user'
  #Google Auth
  get 'auth/:provider/callback', to: 'sessions#create_google'
  get 'auth/failure', to: redirect('/')
  #get 'signout', to: 'sessions#destroy', as: 'signout'
  #get 'login', to: 'sessions#create', as: 'login'

  get 'recover_password', to: 'sessions#recover', as: 'recover_password'
  post 'recover_password', to: 'sessions#recover_password'
  get 'new_password/:id', to: 'sessions#new_password', as: 'new_password'
  post 'new_password/:id', to: 'session#change_password'
  #Webpay
  #post '/webpay/webpay_final_url', :to => 'webpay#webpay_final_url', as: => :webpay_result
  #post '/webpay/webpay_return_url', :to => 'webpay#webpay_return_url', as: => :webpay_return_url
  #get '/webpay/success', :to => 'webpay#webpay_success', as: => :webpay_success
  #get '/webpay/error', :to => 'webpay#webpay_error', as: => :webpay_error
  #get '/webpay/nullify', :to => 'webpay#webpay_nullify', as: => :webpay_nullify



  resources :sessions
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'login', to: 'sessions#new', as: 'login'
  post 'sessions/new', to: 'sessions#create'

  resource :home, only: [:show]
  resources :users
  resources :pollas
  resources :matches
  resources :bets
  resources :transactions

  root to: "home#show"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
