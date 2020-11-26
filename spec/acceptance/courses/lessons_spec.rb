require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.resource "Courses/Lessons" do
  include_context "with authorized API request"

  let(:course_id) { course.id }
  let(:course) { create(:course, title: "Ruby on Rails basics") }

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
            order: be_an(Integer)
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

    example_request "Get a lesson" do
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

    let(:title) { "Active Record" }
    let(:content) { "Active recrod is an ORM pattern..." }

    example_request "Create a lesson" do
      expect(status).to eq(201)
      expect(response).to include(
        lesson: {
          id: be_an(Integer),
          title: "Active Record",
          content: "Active recrod is an ORM pattern...",
          order: 1
        }
      )
    end
  end

  put "/api/v1/courses/:course_id/lessons/:old_lesson_order" do
    let(:old_lesson_order) { lesson.order }
    let(:lesson) { create(:lesson, course: course, order: 5) }

    with_options scope: :lesson, with_example: true do
      parameter :title
      parameter :content
      parameter :order
    end

    let(:order) { 6 }
    let(:title) { "What is ORM?" }
    let(:content) { "ORM (object-relational mapping) - ..." }

    example_request "Update a lesson" do
      expect(status).to eq(200)
      expect(response).to include(
        lesson: {
          id: be_an(Integer),
          title: "What is ORM?",
          content: "ORM (object-relational mapping) - ...",
          order: 6
        }
      )
    end
  end

  delete "/api/v1/courses/:course_id/lessons/:order" do
    let(:order) { 9 }

    before do
      create(
        :lesson, course: course,
                 title: "Meaning of life",
                 content: "42", order: 9
      )
    end

    example_request "Delete a lesson" do
      expect(status).to eq(200)
      expect(response).to include(
        lesson: {
          id: be_an(Integer),
          title: "Meaning of life",
          content: "42",
          order: 9
        }
      )
    end
  end
end
