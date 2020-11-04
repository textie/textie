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
          enrollment.save

          respond_with enrollment
        end

        def update
          enrollment.update(enrollment_params)

          respond_with enrollment
        end

        def destroy
          enrollment.destroy

          respond_with enrollment
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
