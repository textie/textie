module Api
  module V1
    module Courses
      class EnrollmentsController < AuthenticatedController
        expose :course
        expose :enrollment, -> { Enrollment.find_by(enrollment_params) }
        expose :new_enrollment, -> { Enrollment.new(enrollment_params) }

        def show
          if enrollment.present?
            respond_with enrollment
          else
            render json: {
              errors: { enrollment: I18n.t("enrollment.errors.not_found") }
            }, status: :not_found
          end
        end

        def create
          new_enrollment.save

          respond_with new_enrollment
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
