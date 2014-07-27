class Trip < ActiveRecord::Base
  belongs_to :user
  has_many :folders

  geocoded_by :name
  after_validation :geocode, :if => :name_changed?
end
