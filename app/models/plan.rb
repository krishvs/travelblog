class Plan < ActiveRecord::Base
	monetize :price_cent, :allow_nil => true,
	:numericality => {
	    :greater_than_or_equal_to => 0
	  }
	belongs_to :itenary
	serialize :descriptions
	has_many :maps, as: :sub_maps
end
