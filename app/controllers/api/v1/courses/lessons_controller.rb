module Api
  module V1
    module Courses
      class LessonsController < ApplicationController
        expose :course
        expose :lesson, parent: :course, find_by: :order
        expose :lessons, from: :course

        before_action only: :show do
          self.class.serialization_scope :detailed
        end

        def index
          render json: lessons, include: []
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
            render json: lesson, include: []
          else
            render json: {
              errors: lesson.errors
            }, status: :unprocessable_entity
          end
        end

        def destroy
          lesson.destroy

          render json: lesson, include: []
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
