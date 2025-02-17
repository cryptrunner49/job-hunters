Rails.application.routes.draw do
  resources :interviews
  resources :job_applications
  resources :cover_letters
  resources :resumes
  resources :job_offers
  resources :roles
  resources :companies
  root "home#index"
  resource :session, only: %i[new create destroy]
  resources :passwords, only: %i[new create edit update], param: :token

  # Sign-up routes
  get "signup", to: "hunters#new", as: :new_hunter
  post "signup", to: "hunters#create"
end
