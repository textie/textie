require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.resource "Api::V1::Courses::Enrollments" do
  include_context "with authorized API request"

  let(:course_id) { course.id }
  let(:course) { create(:course) }

  get "/api/v1/courses/:course_id/enrollment" do
    context "when user enrolled for the given course" do
      before { create(:enrollment, course: course, user: current_user) }

      example_request "shows enrollment object" do
        expect(status).to eq(200)
        expect(response).to include(
          enrollment: {
            course_id: course.id,
            user_id: current_user.id
          }
        )
      end
    end

    context "when user not enrolled for the given course" do
      example_request "says that there is no enrollment" do
        expect(status).to eq(404)
        expect(response).to include(errors: {})
      end
    end
  end

  post "/api/v1/courses/:course_id/enrollment" do
    context "when user hasn't enrolled for the course" do
      example_request "enrolls this course" do
        expect(status).to eq(201)
        expect(response).to include(
          course_id: course.id,
          user_id: current_user.id
        )
      end
    end

    context "when user has enrolled for the course" do
      before { create(:enrollment, course: course, user: current_user) }

      example_request "reponds with error" do
        expect(status).to eq(422)
        expect(response).to include(
          errors: {
            course_id: [include("taken")]
          }
        )
      end
    end
  end

  delete "/api/v1/courses/:course_id/enrollment" do
    context "when user has enrolled for the course" do
      before { create(:enrollment, course: course, user: current_user) }

      example_request "leaves the course" do
        expect(status).to eq(200)
      end
    end

    context "when user hasn't enrolled for the course" do
      example_request "reponds with not found" do
        expect(status).to eq(404)
      end
    end
  end
end
