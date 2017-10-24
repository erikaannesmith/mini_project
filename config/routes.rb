Rails.application.routes.draw do
  root "welcome#index"

  resources :users do
    resources :designs
  end

  delete '/logout', to: 'sessions#destroy'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

end
