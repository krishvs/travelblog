class AddFolderIdToMaps < ActiveRecord::Migration
  def change
    add_column :maps, :folder_id, :integer
  end
end
