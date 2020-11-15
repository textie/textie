module Api
  module V1
    module Courses
      class EnrollmentsController < AuthenticatedController
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
          params.fetch(:enrollment).permit(:user_id)
        end

        def fetch_enrollments
          current_user.enrollments.joins(:course)
        end
      end
    end
  end
end
