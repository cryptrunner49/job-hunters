Rails.application.routes.draw do
  root "home#index"

  resource :session, only: %i[new create destroy]
  resources :passwords, only: %i[new create edit update], param: :token

  # Sign-up routes
  get "sign_up", to: "hunters#new", as: :new_hunter
  post "sign_up", to: "hunters#create"
  delete "sign_out", to: "sessions#destroy"

  # Others
  resources :resumes
  resources :cover_letters
  resources :roles
  resources :companies
  resources :job_posts, only: %i[new create edit update show destroy]
  resources :job_applications, only: %i[new create edit update show destroy] do
    resources :job_offers, only: %i[index new create edit update show destroy]
    resources :interviews, only: %i[index new create edit update show destroy]
  end

  post "preview", to: "previews#create", as: :preview
  post "preview_resume", to: "previews#resume", as: :preview_resume
  post "preview_cover_letter", to: "previews#cover_letter", as: :preview_cover_letter
end
