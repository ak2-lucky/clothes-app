FactoryBot.define do
  factory :post do
    context { "testText" }
    brand { "Uniqlo" }
    category { "パーカー" }
    rate { 4.5 }
    sex { "mens" }
    association :user
  end
end
