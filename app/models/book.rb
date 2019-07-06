class Book < ApplicationRecord
  belongs_to :user
  has_many :volumes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :evaluations, dependent: :destroy
  has_many :users, through: :favorites
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: :true, length: { maximum: 300 }
  mount_uploader :picture, PictureUploader
end
