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

            def show
            end

            def create
            end

            def update
            end
          end
        end
      end
    end
  end
end
