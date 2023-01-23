Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"


  resources :journeys
  resources :orders, except: :new
  get '/:traveller_id/orders/new', to: 'orders#new', as: "new_order" 


end
