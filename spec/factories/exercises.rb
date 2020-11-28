FactoryBot.define do
  factory :exercise do
    title { "Lesson #{lesson.title}. Exercise #{order}" }
    description { Faker::Lorem.paragraph }
    order { lesson.exercises.count + 1 }
    lesson
  end
end
