Rails.application.routes.draw do
  root "welcome#index"


  namespace :admin do
    resources :partnerships, only: [:index]
    resources :dashboard, only: [:index]
    resources :contacts do 
      resources :users, only: [:index, :show, :destroy]
    end
  end

  resources :users do
    resources :dashboard, only: [:index]
    resources :partnerships, only: [:create]
    resources :contacts
    resources :designs
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
