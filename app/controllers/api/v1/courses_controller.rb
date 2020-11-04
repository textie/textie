module Api
  module V1
    class CoursesController < ApplicationController
      expose :courses, -> { Course.all }
      expose :course, from: :current_user

      def index
      end

      def show
      end

      def create
        result = CreateCourse.call(course: course)

        if result.success
          render :show, status: :created, location: result.course
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      def update
        if course.update(course_params)
          render :show, status: :ok, location: course
        else
          render json: { errors: course.errors }, status: :unprocessable_entity
        end
      end

      private

      def course_params
        params.require(:course).permit(:id, :title, :description)
      end
    end
  end
end
