Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount Raddocs::App => "/docs"

      resources :users, only: %i[create]
      resources :sessions, only: %i[create]
      resource :profile, only: %i[show]

      resources :courses, only: %i[index show create update] do
        resource :enrollments
      end
    end
  end
end
