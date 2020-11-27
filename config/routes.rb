Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount Raddocs::App => "/docs"

      resources :users, only: %i[create]
      resource :session, only: %i[create update]
      resource :profile, only: %i[show]

      resources :courses, only: %i[index show create update] do
        resource :enrollment, only: %i[show create destroy], module: :courses
        resources :lessons, module: :courses
      end
    end
  end
end
