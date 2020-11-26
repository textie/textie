FactoryBot.define do
  factory :lesson do
    title { "#{course.title}. Lesson #{order}" }
    content { Faker::Lorem.paragraphs(number: 10..20).join("\n\n") }
    sequence(:order) { course.lessons.count }
    course
  end
end
