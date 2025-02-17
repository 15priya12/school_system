Rails.application.routes.draw do
  devise_for :admins
  devise_for :schools

  authenticated :admin do
    root to: "schools#index", as: :admin_root
  end

  authenticated :school do
    root to: "students#index", as: :school_root
  end

  root to: "home#index" # Default homepage
  constraints subdomain: /.+/ do
    resources :students, only: [:index, :new, :create]
  end

  resources :schools, only: [:index, :new, :create]
end
