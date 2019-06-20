class Picture < ApplicationRecord
  belongs_to :volume
  mount_uploader :picture, PictureUploader
  serialize :pictures, JSON 
  

def self.create_pictures_by(picture_params)
   Picture.transaction do
     picture_params.each do |index|
      spot = Spot.find(picture_params[index][:id])
      picture_params[index][:pictures]&.each do |photo|
        return false unless spot.photos.create!(image: photo)
      end
    end
  end
end  




end

