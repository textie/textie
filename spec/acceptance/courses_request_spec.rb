require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.resource "Courses" do
  include_context "with authorized API request"

  let!(:course) do
    create(
      :course, author: current_user,
               title: "The best footbal player",
               description: "Lionel Messi"
    )
  end

  get "/api/v1/courses" do
    let!(:second_course) do
      create(
        :course, users: [current_user],
                 title: "The most popular programming languages",
                 description: "C is the most popular programming language."
      )
    end

    example_request "List available courses" do
      expect(response).to include({
        courses: match_array(
          [
            {
              id: course.id,
              title: "The best footbal player",
              description: "Lionel Messi",
              authorId: course.author_id,
              createdAt: be_a_datetime_string(course.created_at)
            },
            {
              id: second_course.id,
              title: "The most popular programming languages",
              description: "C is the most popular programming language.",
              authorId: second_course.author_id,
              createdAt: be_a_datetime_string(second_course.created_at)
            }
          ]
        )
      }.deep_stringify_keys)
    end
  end

  get "/api/v1/courses/:id" do
    let(:id) { course.id }

    example_request "Get detailed info on specific course" do
      expect(response).to include(
        course: {
          id: course.id,
          title: "The best footbal player",
          description: "Lionel Messi",
          authorId: course.author_id,
          createdAt: be_a_datetime_string(course.created_at)
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
      expect(status).to eq(201)
      expect(response).to include(
        course: {
          id: be_an(Integer),
          title: "Course creating 101",
          description: "API testing course",
          authorId: be_an(Integer),
          createdAt: be_a_datetime_string
        }
      )
    end

    context "with no title" do
      let(:title) { nil }

      it_behaves_like "error response", title: ["blank"]
    end

    context "with no description" do
      let(:description) { nil }

      it_behaves_like "error response", description: ["blank"]
    end
  end

  put "/api/v1/courses/:id" do
    let(:id) { course.id }

    with_options scope: :course, with_example: true do
      parameter :title, required: true
      parameter :description, required: true
    end

    let(:title) { "Updating courses guide" }
    let(:description) { "Updating course titles and descriptions" }

    example_request "Update a course" do
      expect(status).to eq(200)
      expect(response).to include(
        course: {
          id: course.id,
          title: "Updating courses guide",
          description: "Updating course titles and descriptions",
          authorId: course.author_id,
          createdAt: be_a_datetime_string(course.created_at)
        }
      )
    end

    context "with no title" do
      let(:title) { nil }

      it_behaves_like "error response", title: ["blank"]
    end
  end
end
