module Api
  module V1
    class CoursesController < AuthorizedApiController
      expose :exercise

      def show
        respond_with exercise
      end
    end
  end
end
