class Post < ApplicationRecord
  belongs_to :user
  
  validates :user_id, presence:true
  validates :context, presence:true, length: {maximum: 140 }
  validates :brand, presence:true
  validates :category, presence:true
  validates :rate, presence:true
  validates :sex, presence:true
end
