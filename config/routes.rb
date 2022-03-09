Rails.application.routes.draw do
  devise_for :super_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :tags
  resources :housings
  resources :transactions
  resources :housing_users
  root to: 'transactions#index'
  devise_for :users
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
