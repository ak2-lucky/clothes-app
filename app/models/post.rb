class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence:true
  validates :context, presence:true, length: {maximum: 300 }
  validates :brand, presence:true
  validates :category, presence:true
  validates :rate, presence:true
  validates :sex, presence:true
  validates :product_name, presence:true
  validate :picture_size
  
  private

   # アップロードされた画像のサイズをバリデーションする
   def picture_size
    if picture.size > 5.megabytes
    　 errors.add(:picture, "を5MBバイトより小さいサイズにしてください")
    end
   end
end
