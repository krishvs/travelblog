class Map < ActiveRecord::Base
	belongs_to :folder
	include PublicActivity::Model
	has_many :addresses
end
