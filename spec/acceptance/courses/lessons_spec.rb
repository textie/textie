require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.resource "Courses/Lessons" do
  include_context "with authorized API request"

  let(:course_id) { course.id }
  let(:course) { create(:course) }

  get "/api/v1/courses/:course_id/lessons" do
    before do
      create(:lesson, title: "Rails controller", course: course)
      create(:lesson, title: "Lesson from another course")
    end

    example_request "List course lessons" do
      expect(response).to include(
        lessons: [
          {
            id: be_an(Integer),
            title: "Rails controller",
            content: be_a(String),
            order: be_an(Integer),
            course: be_a(Hash)
          }
        ]
      )
    end
  end

  get "/api/v1/courses/:course_id/lessons/:order" do
    let(:order) { 2 }

    before do
      create(:lesson, title: "1. Rails controller", course: course, order: 1)
      create(:lesson, title: "2. Strong params", course: course, order: 2)
      create(:lesson, title: "3. Nested routes", course: course, order: 3)
    end

    example_request "List course lessons" do
      expect(response).to include(
        lesson: {
          id: be_an(Integer),
          title: "2. Strong params",
          content: be_a(String),
          order: 2,
          course: be_a(Hash)
        }
      )
    end
  end

  post "/api/v1/courses/:course_id/lessons" do
    with_options scope: :lesson, with_example: true do
      parameter :title, required: true
      parameter :content, required: true
      parameter :order
    end
  end

  put "/api/v1/courses/:course_id/lessons/:order"

  delete "/api/v1/courses/:course_id/lessons/:order"
end
