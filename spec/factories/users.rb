FactoryBot.define do
  factory :user do
    username { "testuser" }
    sex { "男性" }
    height { "170cm台" }
    email { "test@test.com" }
    password { "test-password" }
  end
end
