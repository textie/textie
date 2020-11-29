module Api
  module V1
    module Courses
      module Lessons
        module MultipleChoiceQuestions
          class QuestionOptionsController < AuthorizedApiController
            expose :course
            expose :lesson, parent: :course, find_by: :order
            expose :multiple_choice_question, parent: :lesson
            expose :options, from: :multiple_choice_question
            expose :option, parent: :multiple_choice_question, find_by: :order

            def create

            end

            def destroy
            end

            private

            def question_option_params
              params.require(:question_option).permit(
                :value, :correct
              )
            end
          end
        end
      end
    end
  end
end
