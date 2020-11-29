class MultipleChoiceQuestion < Exercise
  has_many :question_options, foreign_key: "question_id", dependent: :destroy
end
