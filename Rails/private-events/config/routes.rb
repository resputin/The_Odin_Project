Rails.application.routes.draw do
  resources :users, only: [:show, :new, :create] do
    resources :events, only: [:new, :create, :show, :index]
  end
  get   'login',  to: 'sessions#new'
  post  'login',  to: 'sessions#create'
  get   'logout', to: 'sessions#destroy'
end
