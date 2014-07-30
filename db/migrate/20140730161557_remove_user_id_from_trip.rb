class RemoveUserIdFromTrip < ActiveRecord::Migration
  def change
    remove_column :trips, :user_id, :integer
  end
end
