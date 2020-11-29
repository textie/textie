FactoryBot.define do
  factory :multiple_choice_question,
          parent: :exercise,
          class: "MultipleChoiceQuestion" do
    transient do
      question_options { {} }
    end

    after(:create) do |question, evaluator|
      evaluator.question_options.each do |value, correct|
        create(
          :question_option,
          value: value, correct: correct, question: question
        )
      end

      question.reload
    end
  end
end
