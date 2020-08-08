FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@example.com" }
    full_name { FFaker::Name.name }
    password { "123456" }
  end
end
