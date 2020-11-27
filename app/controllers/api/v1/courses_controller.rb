module Api
  module V1
    class CoursesController < AuthenticatedApiController
      skip_before_action :authenticate_user, only: %i[index show]

      expose :courses, -> { Course.all }
      expose :course

      def index
        respond_with courses
      end

      def show
        respond_with course
      end

      def create
        result = CreateCourse.call(course: course)

        if result.success?
          render json: course, status: :created
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def update
        if course.update(course_params)
          render json: course, status: :ok
        else
          render json: { errors: course.errors }, status: :unprocessable_entity
        end
      end

      private

      def course_params
        params.require(:course).permit(
          :id, :title, :description
        ).merge(author: current_user)
      end
    end
  end
end
