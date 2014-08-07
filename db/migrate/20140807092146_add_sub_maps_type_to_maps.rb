class AddSubMapsTypeToMaps < ActiveRecord::Migration
  def change
    add_column :maps, :sub_maps_type, :string
  end
end
