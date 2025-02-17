Rails.application.routes.draw do
  resources :schools, only: [:index, :new, :create]
end
