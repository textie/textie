require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.resource "Courses/Lessons" do
  include_context "with authorized API request"

  let(:course_id) { course.id }
  let(:course) { create(:course) }

  get "/api/v1/courses/:course_id/lessons"

  get "/api/v1/courses/:course_id/lessons/:order"

  post "/api/v1/courses/:course_id/lessons"

  put "/api/v1/courses/:course_id/lessons/:order"

  delete "/api/v1/courses/:course_id/lessons/:order"
end
