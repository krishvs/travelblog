class AddSubMapsIdToMaps < ActiveRecord::Migration
  def change
    add_column :maps, :sub_maps_id, :integer
  end
end
