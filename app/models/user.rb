class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         
  validates :username,  presence: true, length: { maximum: 50 }, uniqueness: true
  validates :sex, presence: true
  validates :height, presence: true
  
end
