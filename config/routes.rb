Rails.application.routes.draw do
  mount ActionCable.server => "/cable"

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root "homes#index"

  resource :anon_session, only: [ :new, :create, :destroy ]
  delete "logout", to: "anon_sessions#destroy", as: "logout"

  resources :questions, only: [ :index, :show ]

  post "create_question", to: "homes#create", as: "create_question"
end
