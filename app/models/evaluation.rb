class Evaluation < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :comment, presence: :true, length: { maximum: 300 }
  validates :star, presence: :true
end
