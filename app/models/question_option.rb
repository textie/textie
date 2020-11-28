class QuestionOption < ApplicationRecord
  SUPPORTED_QUESTION_TYPES = %w[MultipleChoiceQuestion].freeze

  belongs_to :question, class_name: "Exercise"

  validate :question_must_have_a_choice, if: :question

  def question_must_have_a_choice
    return if SUPPORTED_QUESTION_TYPES.include?(question.type)

    errors.add(:question, :invalid_type, type: question.type)
  end
end
