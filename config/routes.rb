Rails.application.routes.draw do
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
