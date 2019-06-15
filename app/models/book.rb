class Book < ApplicationRecord
  belongs_to :user
  has_many :volumes, dependent: :destroy
end
