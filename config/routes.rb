Rails.application.routes.draw do
  root "home#index"
  resource :session, only: %i[new create destroy]
  resources :passwords, only: %i[new create edit update], param: :token

  # Sign-up routes
  get "signup", to: "hunters#new", as: :new_hunter
  post "signup", to: "hunters#create"

  # Others
  # root "job_offers#index"

  resources :candidates
  resources :companies
  resources :roles
  resources :job_offers
  resources :resumes
  resources :cover_letters
  resources :job_applications do
    resources :interviews
  end
end
