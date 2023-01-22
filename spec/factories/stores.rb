FactoryBot.define do
  factory :store do
    store_name {Faker::Company.name}
    sequence(:email) {|n| "tester#{n}@example.com"}
    store_address {"東京都杉並区南阿佐ヶ谷4丁目Offビル1階"}
    business_hours {"9:00 ~ 22:00"}
    password {"password"}
    password_confirmation {"password"}
  end
end
