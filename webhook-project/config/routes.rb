Rails.application.routes.draw do
  devise_for :users
  root "pages#dashboard"

  get "dashboard", to: "pages#dashboard"
  resources :webhooks, only: %i[new create destroy] do
    get "status_check", as: "status_check"
  end
end
