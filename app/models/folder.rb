class Folder < ActiveRecord::Base
  belongs_to :trip
  has_and_belongs_to_many :folders
  has_many :costs
  has_many :descriptions
  has_many :photos
  has_many :reminders
  has_many :documents
  
  mount_uploader :image, ImageUploader
end
