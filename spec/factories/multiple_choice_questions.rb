FactoryBot.define do
  factory :multiple_choice_question,
          parent: :exercise,
          class: "MultipleChoiceQuestion" do
    factory :user_with_posts do
      # posts_count is declared as a transient attribute available in the
      # callback via the evaluator
      transient do
        options_count { 3 }
      end

      # the after(:create) yields two values; the user instance itself and the
      # evaluator, which stores all values from the factory, including transient
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the user is associated properly to the post
      after(:create) do |question, evaluator|
        question.options = create_list(
          :question_option,
          evaluator.options_count,
          question: question
        )
      end
    end
  end
end
