class Volume < ApplicationRecord
  belongs_to :book
  has_many :pictures, -> { order(position: :asc) }
  accepts_nested_attributes_for :pictures
  validate  :picture_size
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, length: { maximum: 150 }

  private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if pictures.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
