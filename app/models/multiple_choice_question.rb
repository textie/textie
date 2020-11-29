class MultipleChoiceQuestion < Exercise
  has_many :question_options, foreign_key: "question_id",
                              dependent: :destroy, inverse_of: "question"

  validate :at_least_one_option_correct

  def at_least_one_option_correct
    return if question_options.where(correct: true).count > 0

    errors.add(:question_options, :at_least_one_correct)
  end
end
