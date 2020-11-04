module Api
  module V1
    module Courses
      class EnrollmentsController < ApplicationController
        expose :course
        expose :enrollment, parent: :course
        expose :enrollments, fetch: :fetch_enrollments

        def index
        end

        def show
        end

        def create
          if enrollment.save
            render :show, status: :created, location: enrollment
          else
            render json: { errors: enrollment.errors }, status: :unprocessable_entity
          end
        end

        def update
          if enrollment.update(enrollment_params)
            render :show, status: :ok, location: enrollment
          else
            render json: { errors: enrollment.errors }, status: :unprocessable_entity
          end
        end

        def destroy
          @enrollment.destroy
        end

        private

        def enrollment_params
          params.fetch(:enrollment)
        end

        def fetch_enrollments
          current_user.enrollments.joins(:course)
        end
      end
    end
  end
end
