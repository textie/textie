require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.resource "Courses" do
  include_context "with authorized API request"
  include_context "when time is frozen"

  let!(:first_course) do
    create(
      :course, users: [current_user],
               title: "The best footbal player",
               description: "Lionel Messi"
    )
  end
  let!(:second_course) do
    create(
      :course, users: [current_user],
               title: "The most popular programming languages",
               description: "C is the most popular programming language."
    )
  end

  get "/api/v1/courses" do
    let(:expected_response) do
      {
        courses: match_array(
          [
            {
              id: first_course.id,
              title: "The best footbal player",
              description: "Lionel Messi",
              author_id: first_course.author_id,
              created_at: current_time.to_s
            },
            {
              id: second_course.id,
              title: "The most popular programming languages",
              description: "C is the most popular programming language.",
              author_id: second_course.author_id,
              created_at: current_time.to_s
            }
          ]
        )
      }.deep_stringify_keys
    end

    example_request "List available courses" do
      expect(response).to include(expected_response)
    end
  end

  get "/api/v1/courses/:id" do
    let(:id) { course.id }
    let(:course) do
      create(
        :course, title: "CS 101",
                 description: "Computer Science for beginners"
      )
    end

    example_request "Get detailed info on specific course" do
      expect(response).to include(
        course: {
          id: course.id,
          title: "CS 101",
          description: "Computer Science for beginners",
          author_id: course.author_id,
          created_at: course.created_at.to_s
        }
      )
    end
  end

  post "/api/v1/courses" do
    with_options scope: :course, with_example: true do
      parameter :title, required: true
      parameter :description, required: true
    end

    let(:title) { "Course creating 101" }
    let(:description) { "API testing course" }

    example_request "Create a course" do
      expect(response).to include(
        course: {
          id: be_an(Integer),
          title: "Course creating 101",
          description: "API testing course",
          author_id: be_an(Integer),
          created_at: be_a(String)
        }
      )
    end
  end

  put "/api/v1/courses/:id" do
    let(:id) { course.id }
    let(:course) { create(:course, author: current_user) }

    with_options scope: :course, with_example: true do
      parameter :title, required: true
      parameter :description, required: true
    end

    let(:title) { "Updating courses guide" }
    let(:description) { "Updating course titles and descriptions" }

    example_request "Update a course" do
      expect(response).to include(
        course: {
          id: course.id,
          title: "Updating courses guide",
          description: "Updating course titles and descriptions",
          author_id: course.author_id,
          created_at: course.created_at.to_s
        }
      )
    end
  end
end
