module Api
  module V1
    module Courses
      module Lessons
        class MultipleChoiceQuestionsController < AuthenticatedApiController
          expose :course
          expose :lesson, parent: :course, find_by: :order
          expose :multiple_choice_question

          def create
            question = MultipleChoiceQuestion.create(
              multiple_choice_question_params
            )
            question_options_params.each do |question_option_params|
              QuestionOption.create(
                question_option_params.merge(question: question)
              )
            end
            question.reload
            respond_with question, include: ["question_options"]
          end

          def update
            render json: {}
          end

          def destory; end

          private

          def multiple_choice_question_params
            params.require(:multiple_choice_question).permit(
              :title, :description, question_options: []
            ).merge(lesson: lesson)
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
