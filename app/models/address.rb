class Address < ActiveRecord::Base
	belongs_to :map
	
	geocoded_by :address
	after_validation :geocode, :if => :address_changed?
end
