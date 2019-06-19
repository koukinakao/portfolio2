class Picture < ApplicationRecord
  belongs_to :volume
  mount_uploader :picture, PictureUploader
  serialize :pictures, JSON 
end
