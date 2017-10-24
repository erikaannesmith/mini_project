Rails.application.routes.draw do
  root "welcome#index"

  resources :users

  delete '/logout', to: 'sessions#destroy'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

end
