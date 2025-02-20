Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: "api/sessions" }
  devise_for :schools, controllers: { sessions: "api/sessions" }

  authenticated :admin do
    root to: "schools#index", as: :admin_root
  end

  authenticated :school do
    root to: "students#index", as: :school_root
  end

  root to: "home#index" # Default homepage

  constraints subdomain: /.+/ do
    resources :students, only: [:index, :create]
  end

  resources :schools, only: [:index, :create, :destroy]
  get "/schools/:id/delete", to: "schools#destroy", as: "delete_school"

  namespace :api, defaults: { format: :json } do
    resources :schools, only: [:index, :create, :destroy]
    resources :students, only: [:index, :create]
  end
end
