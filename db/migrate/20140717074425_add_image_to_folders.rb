class AddImageToFolders < ActiveRecord::Migration
  def change
    add_column :folders, :image, :string
  end
end
