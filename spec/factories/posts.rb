FactoryBot.define do
  factory :post do
    content { "testText" }
    brand { "UNIQLO" }
    category { "トップス" }
    rate { 4.5 }
    sex { "Mens" }
    product_name { "スウェットプルオーバーパーカー" }
    association :user
  end
end
