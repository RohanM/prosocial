Rails.application.routes.draw do
  resources :sessions

  root to: "sessions#index"
end
