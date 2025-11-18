Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "tasks#index"

  resources :tasks do
    member do
      patch :toggle_completed
    end
  end
end
