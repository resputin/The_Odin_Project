Rails.application.routes.draw do

  devise_for :users
  resources :users
  resources :friend_requests
  root to: "static_pages#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
