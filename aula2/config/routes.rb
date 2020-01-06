Rails.application.routes.draw do
  resources :weapons, only: [ :index, :create, :destroy, :show ]
  resources :users, only: [:index, :create]
  resources :enemies, only: [:update, :destroy]
end
