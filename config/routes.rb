Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users
  resources :rooms
  resources :questions, only: [:index, :show]

  post '/', to: 'room_auth#create'

  post '/users/test', to: 'users#test'

  get '/socket', to: 'rooms#socket'

  mount ActionCable.server => '/cable'

end
