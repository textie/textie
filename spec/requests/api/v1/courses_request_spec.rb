require "rails_helper"

RSpec.describe "Api::V1::Courses", type: :request do
  include_context "with authorized API request"

  def create_course(user)
    create(:course) do |course|
      course.enrollments.create(user: user)
    end
  end

  describe "GET /api/v1/courses" do
    let(:do_request) { get "/api/v1/courses", headers: auth_header }

    let(:courses) do
      [
        create_course(current_user),
        create_course(current_user)
      ]
    end

    it "returns all courses" do
      courses
      expect(response_body).to match("courses" => courses)
    end
  end

  describe "GET /api/v1/courses/:id"

  describe "POST /api/v1/courses"

  describe "PUT /api/v1/courses"

  describe "DELETE /api/v1/courses/:id"
end
