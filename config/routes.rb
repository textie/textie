Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount Raddocs::App => "/docs"

      resources :exercises, only: %i[show]
      resources :users, only: %i[create]

      resource :profile, only: %i[show]
      resource :session, only: %i[create update]

      resources :courses, only: %i[index show create update] do
        scope module: :courses do
          resource :enrollment, only: %i[show create destroy]

          resources :lessons do
            scope module: :lessons do
              resources :multiple_choice_questions, only: %i[create update destroy]
            end
          end
        end
      end
    end
  end
end
