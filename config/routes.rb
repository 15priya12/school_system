Rails.application.routes.draw do
  constraints subdomain: /.+/ do
    resources :students, only: [:index, :new, :create]
  end

  resources :schools, only: [:index, :new, :create]
end
