require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.resource "Courses/Lessons/Exercises" do
  include_context "with authorized API request"

  let(:lesson) { create(:lesson) }

  before do
    create(
      :multiple_choice_question,
      title: "Java Interview Question #1",
      description: "What can keyword `static` can be applied to?",
      lesson: lesson,
      question_options: {
        "method" => true,
        "class" => false,
        "nested class" => true,
        "attribute" => true,
        "local variable" => false,
        "method parameter" => false
      }
    )
    create(
      :multiple_choice_question,
      title: "JavaScript Interview Question #2",
      description: "What are keywords to declare a variable?",
      lesson: lesson,
      question_options: {
        "let" => true,
        "val" => false,
        "var" => true,
        "int" => false,
        "const" => true
      }
    )
  end

  get "/api/v1/courses/:course_id/lessons/:lesson_order/exercises" do
    let(:course_id) { lesson.course_id }
    let(:lesson_order) { lesson.order }

    context "when user enrolled to the course" do
      before do
        create(:enrollment, user: current_user, course_id: lesson.course_id)
      end

      example_request "View lesson's exercises" do
        expect(status).to eq(200)
        expect(response).to include({
          multipleChoiceQuestions: match_array(
            [
              {
                id: be_an(Integer),
                type: "MultipleChoiceQuestion",
                order: 1,
                lessonId: lesson.id,
                title: "Java Interview Question #1",
                description: "What can keyword `static` can be applied to?"
              },
              {
                id: be_an(Integer),
                type: "MultipleChoiceQuestion",
                order: 2,
                lessonId: lesson.id,
                title: "JavaScript Interview Question #2",
                description: "What are keywords to declare a variable?"
              }
            ]
          )
        })
      end
    end
  end
end
