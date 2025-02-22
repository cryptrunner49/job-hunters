Rails.application.routes.draw do
  root "home#index"

  resource :session, only: %i[new create destroy]
  resources :passwords, only: %i[new create edit update], param: :token

  # Sign-up routes
  get "sign_up", to: "hunters#new", as: :new_hunter
  post "sign_up", to: "hunters#create"
  delete "sign_out", to: "sessions#destroy"

  # Others
  resources :companies, only: %i[new create edit update show destroy]
  resources :roles, only: %i[new create edit update show destroy]
  resources :job_posts, only: %i[new create edit update show destroy]
  resources :job_offers, only: %i[new create edit update show destroy]
  resources :resumes
  resources :cover_letters
  resources :job_applications, only: %i[new create edit update show destroy] do
    resources :interviews, only: %i[new create edit update show destroy]
  end

  post "preview", to: "previews#create", as: :preview
end
