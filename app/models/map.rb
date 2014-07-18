class Map < ActiveRecord::Base
	belongs_to :folder
	has_many :addresses
end
