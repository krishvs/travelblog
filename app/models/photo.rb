class Photo < ActiveRecord::Base
  belongs_to :folder
  mount_uploader :image, ImageUploader
  
end
