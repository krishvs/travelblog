class CreateReminders < ActiveRecord::Migration
  def change    
    create_table :reminders do |t|
      t.string :name
      t.integer :mode
      t.text :description
      t.integer :sent

      t.timestamps
    end
  end
end
