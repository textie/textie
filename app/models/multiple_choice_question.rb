class MultipleChoiceQuestion < Exercise
  has_many :options, class_name: "QuestionOption", dependent: :destroy
end
