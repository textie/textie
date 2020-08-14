Rails.application.routes.draw do
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :users, only: %i[create]
      resources :sessions, only: %i[create]
      resource :profile, only: %i[show]

      resources :courses
    end
  end
end
