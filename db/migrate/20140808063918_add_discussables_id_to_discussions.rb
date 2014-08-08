class AddDiscussablesIdToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :discussables_id, :integer
  end
end
