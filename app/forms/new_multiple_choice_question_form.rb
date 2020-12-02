class NewMultipleChoiceQuestionForm
  include ActiveModel::Model

  attr_accessor :title, :description, :lesson, :question_options

  validates :title, presence: true
  validates :description, presence: true
  validates :lesson, presence: true

  validate :at_least_one_correct_option

  def save
    return if invalid?

    MultipleChoiceQuestion.transaction do
      question = MultipleChoiceQuestion.create(
        title: title, description: description, lesson: lesson
      )
      question_options.each do |option_params|
        QuestionOption.create(option_params.merge(question: question))
      end
      question.reload
    end
  end

  private

  def at_least_one_correct_option
    return if question_options.any? { |option| option[:correct] }

    errors.add(:question_options, :at_least_one_correct)
  end
end
