class AddMapIdToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :map_id, :integer
  end
end
