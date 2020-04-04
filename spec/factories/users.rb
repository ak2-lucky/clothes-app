FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "name_#{n}" }
    sex { "男性" }
    height { "170cm台" }
    sequence(:email) { |n| "test#{n}@test.com" }
    password { "test-password" }
    password_confirmation { "test-password" }
  end
end
