class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :post
  belongs_to :comment
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id'
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id'
end
