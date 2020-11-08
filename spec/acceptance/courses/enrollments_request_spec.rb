require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.resource "Courses/Enrollments" do
  include_context "with authorized API request"

  let(:course_id) { course.id }
  let(:course) { create(:course) }

  get "/api/v1/courses/:course_id/enrollment" do
    context "when user enrolled for the given course" do
      before { create(:enrollment, course: course, user: current_user) }

      example_request "See enrollment details if already enrolled" do
        expect(status).to eq(200)
        expect(response).to include(
          enrollment: {
            id: be_an(Integer),
            courseId: course.id,
            userId: current_user.id
          }
        )
      end
    end

    context "when user not enrolled for the given course" do
      example_request "Get error accessing not existing unenrollment" do
        expect(status).to eq(404)
        expect(response).to include(
          errors: {
            enrollment: include("not found")
          }
        )
      end
    end
  end

  post "/api/v1/courses/:course_id/enrollment" do
    context "when user hasn't enrolled for the course" do
      example_request "Enroll for a course" do
        expect(status).to eq(201)
        expect(response).to include(
          enrollment: {
            id: be_an(Integer),
            courseId: course.id,
            userId: current_user.id
          }
        )
      end
    end

    context "when user has enrolled for the course" do
      before { create(:enrollment, course: course, user: current_user) }

      example_request "Get rejected when enrolling for enrolled course" do
        expect(status).to eq(422)
        expect(response).to include(
          errors: {
            course: [include("enrolled")]
          }
        )
      end
    end
  end

  delete "/api/v1/courses/:course_id/enrollment" do
    context "when user has enrolled for the course" do
      before { create(:enrollment, course: course, user: current_user) }

      example_request "Leave/unenroll a course" do
        expect(status).to eq(200)
      end
    end

    context "when user hasn't enrolled for the course" do
      example_request "Leave/unenroll unenrolled course" do
        expect(status).to eq(404)
      end
    end
  end
end
