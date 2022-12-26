Rails.application.routes.draw do
  devise_for :user_credentials
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"

  

  resources :travellers do
    resources :journeys
  end
end
