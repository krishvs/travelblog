class Trip < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :folders

  geocoded_by :name
  after_validation :geocode, :if => :name_changed?
end
