module Api
  module V1
    module Courses
      module Lessons
        class MultipleChoiceQuestionsController < AuthorizedApiController
          expose :course
          expose :lesson, parent: :course, find_by: :order
          expose :multiple_choice_question, parent: :lesson

          def create; end

          def update; end

          def destory; end
        end
      end
    end
  end
end
