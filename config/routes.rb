Rails.application.routes.draw do
  devise_for :users, controllers: { 
    sessions: 'users/sessions', 
    registrations: 'users/registrations',
    
  }
  scope 'user/' do 
    get 'profile', to: 'users/manages#profile'
  end
  get 'assign_role', to: 'home#assign_role'
  root to: "home#index"


  resources :journeys
  resources :orders
  # get '/:traveller_id/orders/new', to: 'orders#new', as: "new_order"
  get 'traveller_list', to: 'users/manages#traveller_list'


end
