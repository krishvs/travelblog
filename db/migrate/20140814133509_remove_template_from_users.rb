class RemoveTemplateFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :template, :text
  end
end
