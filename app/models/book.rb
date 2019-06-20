class Book < ApplicationRecord
  belongs_to :user
  has_many :volumes, dependent: :destroy
  mount_uploader :picture, PictureUploader
end
