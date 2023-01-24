Rails.application.routes.draw do
  devise_for :users, controllers: { 
    sessions: 'users/sessions', 
    registrations: 'users/registrations',
    
  }
  devise_scope :user do 
    get 'profile', to: 'users/manages#profile'
  end
  get 'assign_role', to: 'home#assign_role'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"


  resources :journeys
  resources :orders, except: :new
  get '/:traveller_id/orders/new', to: 'orders#new', as: "new_order"
  get 'traveller_list', to: 'manages#traveller_list'


end
