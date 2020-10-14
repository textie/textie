FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@example.com" }
    sequence(:full_name) { |n| "User #{n}" }
    password { "123456" }
  end
end
