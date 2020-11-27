module Api
  module V1
    class CoursesController < AuthorizedApiController
      skip_auth only: %i[index show]

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

        respond_with result.course
      end

      def update
        course.update(course_params)

        respond_with course
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
