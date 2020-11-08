module Api
  module V1
    module Courses
      class LessonsController < ApplicationController
        expose :course
        expose :lessons, parent: :course
        expose :lesson

        def index
          render json: lessons
        end

        def show
          render json: lesson
        end

        def create
          if lesson.save
            render json: lesson, status: :created
          else
            render json: { errors: lesson.errors }, status: :unprocessable_entity
          end
        end

        def update
          if lesson.update(lesson_params)
            render json: lesson
          else
            render json: { errors: lesson.errors }, status: :unprocessable_entity
          end
        end

        def destroy
          lesson.destroy

          respond_with lesson
        end

        private

        def lesson_params
          params.require(:lesson).permit(:title, :content, :order)
        end
      end
    end
  end
end
