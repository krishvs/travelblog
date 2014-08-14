class AddTemplateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :template, :text
  end
end
