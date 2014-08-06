class AddModeToItenaries < ActiveRecord::Migration
  def change
    add_column :itenaries, :mode, :integer
  end
end
