Rails.application.routes.draw do

  resources :users
  resources :events, only: [:new, :create, :destroy, :index, :show]

  get    '/log_in',  to: 'sessions#new'
  post   '/log_in',  to: 'sessions#create'
  delete '/log_out', to: 'sessions#destroy'

end
