class Plan < ActiveRecord::Base
	belongs_to :itenary
	has_many :maps, as: :sub_maps
end
