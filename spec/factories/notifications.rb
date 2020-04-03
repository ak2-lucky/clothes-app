FactoryBot.define do
  factory :notification do
    checked { false }
    visitor_id { 1 }
    visited_id { 2 }
    association :post
    association :comment
  end
end
