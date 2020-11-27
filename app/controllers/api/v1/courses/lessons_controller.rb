module Api
  module V1
    module Courses
      class LessonsController < AuthorizedApiController
        expose :course
        expose :lesson, parent: :course, find_by: :order
        expose :lessons, from: :course

        def index
          render json: lessons, include: []
        end

        def show
          respond_with lesson
        end

        def create
          result = CreateLesson.call(lesson: lesson)

          respond_with result.lesson, include: []
        end

        def update
          lesson.update(lesson_params)

          respond_with lesson, include: []
        end

        def destroy
          lesson.destroy

          respond_with lesson, include: []
        end

        private

        def lesson_params
          params.require(:lesson).permit(
            :title, :content, :order
          ).merge(course: course)
        end
      end
    end
  end
end
