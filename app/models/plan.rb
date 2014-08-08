class Plan < ActiveRecord::Base
	belongs_to :itenary
	serialize :descriptions, Array
	has_many :maps, as: :sub_maps
end
