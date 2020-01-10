Rails.application.routes.draw do
  resources :weapons, only: [ :index, :create, :destroy, :show ]
  resources :users, only: [:index, :create]
  resources :enemies, only: [:index, :show, :update, :destroy, :create]
end
