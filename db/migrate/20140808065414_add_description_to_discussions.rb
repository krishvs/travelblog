class AddDescriptionToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :description, :text
  end
end
