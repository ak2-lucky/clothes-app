class Post < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence:true
  validates :context, presence:true, length: {maximum: 140 }
  validates :brand, presence:true
  validates :category, presence:true
  validates :rate, presence:true
  validates :sex, presence:true
  validates :product_name, presence:true
  validate :picture_size
  
  private

   # アップロードされた画像のサイズをバリデーションする
   def picture_size
    if picture.size > 1.megabytes
     errors.add(:picture, "1MBより小さくすべきです")
    end
   end
end
