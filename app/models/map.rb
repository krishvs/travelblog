class Map < ActiveRecord::Base
	belongs_to :sub_map, polymorphic: true
	include PublicActivity::Model
	has_many :addresses
end
