class AddDiscussablesTypeToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :discussables_type, :string
  end
end
