Rails.application.routes.draw do
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      mount Raddocs::App => "/docs"

      resources :users, only: %i[create]
      resources :sessions, only: %i[create]
      resource :profile, only: %i[show]

      resources :courses, only: %i[index show create update] do
        resource :enrollment, only: %i[show create destroy], module: :courses
      end
    end
  end
end
