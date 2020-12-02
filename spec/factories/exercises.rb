FactoryBot.define do
  factory :exercise do
    title { Faker::Lorem.question }
    description { Faker::Lorem.questions }
    lesson
  end
end
