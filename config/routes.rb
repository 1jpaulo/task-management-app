Rails.application.routes.draw do
  root "cards#index"

  resources :cards do
    collection do
      post :create_card
    end
  end
  resources :sessions, only: %i[new create destroy]

  get "up" => "rails/health#show", as: :rails_health_check
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
