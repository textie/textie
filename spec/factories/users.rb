FactoryBot.define do
  factory :user, aliases: [:author] do
    sequence(:email) { |n| "user_#{n}@example.com" }
    full_name { Faker::Name.name }
    password { "123456" }
  end
end
