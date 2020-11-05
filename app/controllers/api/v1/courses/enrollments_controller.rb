module Api
  module V1
    module Courses
      class EnrollmentsController < ApplicationController
        expose :course
        expose :enrollment, -> { Enrollment.find_by(enrollment_params) }
        expose :new_enrollment, -> { Enrollment.new(enrollment_params) }

        def show
          if enrollment.present?
            render :show, status: :ok
          else
            # TODO: respond with error
            render json: { errors: {} }, status: :not_found
          end
        end

        def create
          if new_enrollment.save
            render :show, locals: { enrollment: new_enrollment }, status: :created
          else
            render json: { errors: new_enrollment.errors }, status: :unprocessable_entity
          end
        end

        def destroy
          if enrollment.present?
            enrollment.destroy
            head :ok
          else
            head :not_found
          end
        end

        private

        def enrollment_params
          { course: course, user: current_user }
        end
      end
    end
  end
end
