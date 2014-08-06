class Folder < ActiveRecord::Base
  include PublicActivity::Model	

  belongs_to :trip
  has_and_belongs_to_many :folders
  has_many :costs
  has_many :maps
  has_many :descriptions
  has_many :photos
  has_many :reminders
  has_many :documents
  has_many :itenaries
  
  mount_uploader :image, ImageUploader
end
