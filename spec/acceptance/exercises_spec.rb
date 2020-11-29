require "rails_helper"
require "rspec_api_documentation/dsl"

RSpec.resource "Exercises" do
  include_context "with authorized API request"

  let(:exercise) do
    create(
      :multiple_choice_question,
      title: "Classic arithmetic problem",
      description: "2 x 2 = ?\nPlease choose all correct answers",
      question_options: {
        5 => false,
        4 => true,
        3 => false,
        4.0 => true
      }
    )
  end

  get "/api/v1/exercises/:exercise_id" do
    let(:exercise_id) { exercise.id }

    context "when user enrolled to the course" do
      before do
        create(:enrollment, user: current_user, course: exercise.lesson.course)
      end

      example_request "View an exercise" do
        expect(status).to eq(200)
        expect(response).to include(
          multipleChoiceQuestion: {
            id: exercise.id,
            order: exercise.order,
            lessonId: exercise.lesson_id,
            type: "MultipleChoiceQuestion",
            title: exercise.title,
            description: exercise.description,
            questionOptions: match_array(
              [
                { id: be_an(Integer), value: "4" },
                { id: be_an(Integer), value: "3" },
                { id: be_an(Integer), value: "5" },
                { id: be_an(Integer), value: "4.0" }
              ]
            )
          }
        )
      end
    end
  end
end
