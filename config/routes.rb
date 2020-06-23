Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :show]
  resources :rooms, only: [:index, :show]
  resources :questions, only: [:index, :show]

  mount ActionCable.server => '/cable'

end
