class CreateFoldersFolders < ActiveRecord::Migration
  def change
    create_table :folders_folders do |t|
      t.belongs_to :folder, index: true
      t.belongs_to :folder, index: true
    end
  end
end
