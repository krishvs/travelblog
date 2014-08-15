class AddOwnerToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :owner, :integer
  end
end
