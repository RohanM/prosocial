Rails.application.routes.draw do
  resources :sessions
  resources :events

  root to: "sessions#index"
end
