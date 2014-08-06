class CreateItenaries < ActiveRecord::Migration
  def change
    create_table :itenaries do |t|
      t.string :name
      t.integer :user_id
      t.integer :folder_id

      t.timestamps
    end
  end
end
