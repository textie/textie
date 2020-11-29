module Api
  module V1
    class ExercisesController < AuthorizedApiController
      expose :exercise

      def show
        respond_with exercise
      end
    end
  end
end
