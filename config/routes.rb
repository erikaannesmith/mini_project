Rails.application.routes.draw do
  root "welcome#index"

  resources :users do
    resources :contacts
    resources :designs
  end

  resources :contacts do
    resources :users
  end

  delete '/logout', to: 'sessions#destroy'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

end
