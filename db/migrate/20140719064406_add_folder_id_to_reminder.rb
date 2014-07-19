class AddFolderIdToReminder < ActiveRecord::Migration
  def change
    add_column :reminders, :folder_id, :integer
  end
end
