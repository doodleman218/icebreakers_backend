Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :show, :new, :create]
  resources :rooms, only: [:index, :show, :new, :create]
  resources :questions, only: [:index, :show]

  mount ActionCable.server => '/cable'

end
