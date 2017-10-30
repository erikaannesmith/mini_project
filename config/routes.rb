Rails.application.routes.draw do
  root "welcome#index"


  namespace :admin do
    resources :partnerships, only: [:index]
    resources :dashboard, only: [:index]
    resources :contacts 
    resources :users, only: [:index, :show, :destroy]
  end

  resources :users do
    resources :dashboard, only: [:index]
    resources :partnerships, only: [:index, :show, :new, :create, :destroy]
    resources :contacts
    resources :designs do 
      resources :images, only: [:new, :create, :destroy, :show]
    end
  end

  # resources :contacts do
  #   resources :users
  # end
  # resources :partnerships
  # get '/admin' to: 'admin#index' #dahsboard

  delete '/logout', to: 'sessions#destroy'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

end
