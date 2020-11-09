module Api
  module V1
    module Courses
      class LessonsController < ApplicationController
        expose :course
        expose :lesson, parent: :course, find_by: :order
        expose :lessons, from: :course

        def index
          render json: lessons
        end

        def show
          render json: lesson
        end

        def create
          result = CreateLesson.call(lesson: lesson)
          if result.success?
            render json: result.lesson, include: [], status: :created
          else
            render json: {
              errors: result.errors
            }, status: :unprocessable_entity
          end
        end

        def update
          if lesson.update(lesson_params)
            render json: lesson
          else
            render json: {
              errors: lesson.errors
            }, status: :unprocessable_entity
          end
        end

        def destroy
          lesson.destroy

          respond_with lesson
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
