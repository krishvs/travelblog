class Map < ActiveRecord::Base
	belongs_to :sub_map, polymorphic: true
	include PublicActivity::Model
	has_many :addresses
	after_create :set_public_url

	def set_public_url
		if self.sub_maps_type == "Folder"
			parent_model = Folder.find_by_id(self.sub_maps_id);
			self.url = "#{parent_model.trip.id}_#{parent_model.trip.name}_#{parent_model.name}_#{self.name}" 
			self.save
		end
	end 
end
