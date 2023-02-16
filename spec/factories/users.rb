FactoryBot.define do
  factory :user do
    user_name { Faker::Name.name }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
