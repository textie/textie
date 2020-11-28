FactoryBot.define do
  factory :question_option do
    value { Faker::Lorem.sentence }
    correct { false }
    question { nil }
  end
end
