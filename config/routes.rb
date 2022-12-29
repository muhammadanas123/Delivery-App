Rails.application.routes.draw do
  devise_for :user_credentials
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"

  

  resources :travellers do
    resources :journeys
  end

  resources :senders do
    resources :orders, except: :new
    get '/:traveller_id/orders/new', to: 'orders#new', as: "new_order" 
  end
  get 'traveller_list', to: 'senders#traveller_list'


end
