require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.resource "Api::V1::Courses" do
  include_context "with authorized API request"

  course_attributes = %w[id title description author_id created_at]

  get "/api/v1/courses" do
    let!(:courses) { create_list(:course, 2) }

    example_request "returns all courses" do
      courses
      expect(response_body).to match_json(
        courses: courses.map { |c| c.slice(*course_attributes) }
      )
    end
  end

  get "/api/v1/courses/:id" do
    let(:id) { course.id }
    let(:course) { create(:course) }

    example_request "returns one course" do
      expect(response_body).to match_json(
        course: course.slice(*course_attributes)
      )
    end
  end

  post "/api/v1/courses" do
    with_options scope: :course, with_example: true do
      parameter :title
      parameter :description
    end

    let(:course_params) { attributes_for(:course) }
    let(:raw_post) { { course: course_params }.to_json }

    example "creating course" do
      do_request({ course: course_params })

      expect(response_body).to match_json(
        course: course_params.merge(
          id: be_an(Integer),
          created_at: be_a(String),
          author_id: be_an(Integer)
        )
      )
    end
  end

  put "/api/v1/courses/:id" do
  end

  delete "/api/v1/courses/:id" do
  end
end
