require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.resource "Courses/Lessons/MultipleChoiceQuestions" do
  include_context "with authorized API request"

  let(:course) { create(:course, author: current_user) }
  let(:lesson) { create(:lesson, course: course) }

  post "/api/v1/courses/:course_id/lessons" \
       "/:lesson_order/multiple_choice_questions" do
    let(:course_id) { lesson.course_id }
    let(:lesson_order) { lesson.order }

    with_options scope: :multiple_choice_question, with_example: true do
      parameter :title, required: true
      parameter :description, required: true
      parameter :question_options, type: :array, items: {
        type: :object
      }
    end

    let(:title) { "Ruby question #1" }
    let(:description) do
      "What does `?` (question mark) mean in the end of a method?"
    end
    let(:question_options) do
      [
        {
          value: "This symbol can't be used in a method name", correct: false
        },
        {
          value: "The method returns true or false", correct: true
        },
        {
          value: "Patter matching by method name", correct: false
        }
      ]
    end

    example_request "Create a multiple choice question" do
      expect(status).to eq(201)
      expect(response).to include(
        multipleChoiceQuestion: {
          id: MultipleChoiceQuestion.last.id,
          type: "MultipleChoiceQuestion",
          title: "Ruby question #1",
          description: "What does `?` (question mark)" \
            " mean in the end of a method?",
          lessonId: lesson.id,
          questionOptions: [
            {
              id: be_an(Integer),
              value: "This symbol can't be used in a method name",
              correct: false
            },
            {
              id: be_an(Integer),
              value: "The method returns true or false",
              correct: true
            },
            {
              id: be_an(Integer),
              value: "Patter matching by method name",
              correct: false
            }
          ]
        }
      )
    end
  end

  patch "/api/v1/courses/:course_id/lessons" \
        "/:lesson_order/multiple_choice_questions/:id" do
    pending
  end

  delete "/api/v1/courses/:course_id/lessons" \
         "/:lesson_order/multiple_choice_questions/:id" do
    pending
  end
end
