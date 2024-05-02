Rails.application.routes.draw do
  devise_for :users
  root to: "home#top"
  get "home/about"
  resources :books, only: [:edit, :create, :index, :show, :destroy, :update]
  resources :users, only: [:show, :edit, :update, :index, :update,]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
