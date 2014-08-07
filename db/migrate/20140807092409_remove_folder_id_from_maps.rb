class RemoveFolderIdFromMaps < ActiveRecord::Migration
  def change
    remove_column :maps, :folder_id, :integer
  end
end
