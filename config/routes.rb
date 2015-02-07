Rails.application.routes.draw do
  resources :sessions
  resources :landing
  resources :events

  root to: "sessions#index"
end
