class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         
  validates :username,  presence: true, length: { maximum: 50 }, uniqueness: true
  validates :sex, presence: true
  validates :height, presence: true
end
