class Book < ApplicationRecord
  belongs_to :user
  has_many :volumes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :evaluations, dependent: :destroy
  has_many :users, through: :favorites
  mount_uploader :picture, PictureUploader
end
