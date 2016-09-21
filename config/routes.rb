Rails.application.routes.draw do
  devise_for :users
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'application#angular'

  post '/auth/:provider', to: 'auth#authenticate'

  resources :posts, only: [:create, :index, :show]
  resources :categories, only: [:index, :show]
end
