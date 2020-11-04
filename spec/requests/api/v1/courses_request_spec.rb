require "rails_helper"

RSpec.describe "Api::V1::Courses", type: :request do
  include_context "with authorized API request"
  include_context :when_time_is_frozen

  let(:author) { create :user }
  let!(:first_course) do
    create(:course, users: [current_user], title: "The best footbal player",
      description: "Lionel Messi", author: author)
  end
  let!(:second_course) do
    create(:course, users: [current_user], author: author,
      title: "The most popular programming languages",
      description: "C is the most popular programming language.")
  end

  describe "GET /api/v1/courses" do
    let(:do_request) { get "/api/v1/courses", headers: auth_header }

    let(:expected_response) do
      {
        courses: [
          {
            id: first_course.id,
            title: "The best footbal player",
            description: "Lionel Messi",
            author_id: author.id,
            created_at: Time.current.utc.to_s
          },
          {
            id: second_course.id,
            title: "The most popular programming languages",
            description: "C is the most popular programming language.",
            author_id: author.id,
            created_at: Time.current.utc.to_s
          }
        ]
      }.deep_stringify_keys
    end

    it "returns all courses" do
      expect(response_body).to match(expected_response)
    end
  end

  describe "GET /api/v1/courses/:id"

  describe "POST /api/v1/courses"

  describe "PUT /api/v1/courses"

  describe "DELETE /api/v1/courses/:id"
end
