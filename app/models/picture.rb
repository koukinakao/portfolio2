class Picture < ApplicationRecord
  belongs_to :volume, :touch => true
  acts_as_list scope: :volume
  mount_uploader :picture, PictureUploader
  serialize :pictures, JSON 
  validates :picture, presence: :true
  






end

