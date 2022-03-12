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
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
