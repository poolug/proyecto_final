Rails.application.routes.draw do
  devise_for :super_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :tags
  resources :housings
  resources :transactions
  resources :housing_users
  root to: 'home#index'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :users

  # cancelar edición del current_user sin recargar página
  get 'users/:id/cancel', to: 'users#cancel_editing', as: 'cancel'

  # crear usuarios a las viviendas
  post 'housings/:id/create_member', to: 'housings#create_member', as: 'create_member'
  get 'housings/:id/add_member', to: 'housings#add_member', as: 'add_member'

  # post 'housings/rating_member', to: 'housings#rating_member', as: 'rating_member'
  # get 'housings/:id/add_rating_member', to: 'housings#add_rating_member', as: 'add_rating_member'
  
  # agregar evaluación para los miembros de una vivienda
  post 'housings/:id/rating_member', to: 'housings#rating_member', as: 'rating_member'
  patch 'housings/:id/add_rating_member', to: 'housings#add_rating_member', as: 'add_rating_member'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
