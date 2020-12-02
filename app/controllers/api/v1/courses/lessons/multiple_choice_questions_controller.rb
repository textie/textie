module Api
  module V1
    module Courses
      module Lessons
        class MultipleChoiceQuestionsController < AuthenticatedApiController
          expose :course
          expose :lesson, parent: :course, find_by: :order
          expose :multiple_choice_question

          def create
            new_question = NewMultipleChoiceQuestionForm.new(
              multiple_choice_question_params
            )
            new_question.save
            respond_with new_question, include: ["question_options"]
          end

          def update
            render json: {}, include: ["question_options"]
          end

          def destory
            multiple_choice_question.destory
            respond_with multiple_choice_question
          end

          private

          def multiple_choice_question_params
            params.require(:multiple_choice_question).permit(
              :title, :description
            ).merge(lesson: lesson, question_options: question_options_params)
          end

          def question_options_params
            params.require(:multiple_choice_question)
                  .require(:question_options)
                  .map { |q| q.permit(:value, :correct) }
          end
        end
      end
    end
  end
end
