module Api
  module V1
    class ExercisesController < AuthorizedApiController
      expose :exercise

      def show
        respond_with exercise, except: [{ "question_options" => "correct" }]
      end
    end
  end
end
