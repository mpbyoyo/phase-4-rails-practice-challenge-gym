Rails.application.routes.draw do
  resources :memberships, only: [:create]
  resources :clients, only: [:show, :index, :update]
  resources :gyms, only: [:destroy, :show, :index, :update]
end
