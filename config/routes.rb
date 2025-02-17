Rails.application.routes.draw do
  root "home#index"
  resource :session, only: %i[new create destroy]
  resources :passwords, only: %i[new create edit update], param: :token

  # Sign-up routes
  get "signup", to: "users#new", as: :new_user
  post "signup", to: "users#create"
end
