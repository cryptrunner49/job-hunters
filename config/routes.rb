Rails.application.routes.draw do
  root "home#index"

  resource :session, only: %i[new create destroy]
  resources :passwords, only: %i[new create edit update], param: :token

  # Sign-up routes
  get "sign_up", to: "hunters#new", as: :new_hunter
  post "sign_up", to: "hunters#create"
  delete "sign_out", to: "sessions#destroy"

  # Others
  resources :candidates
  resources :companies
  resources :roles
  resources :job_posts
  resources :job_offers
  resources :resumes
  resources :cover_letters
  resources :job_applications do
    resources :interviews
  end

  post "preview", to: "previews#create", as: :preview
end
