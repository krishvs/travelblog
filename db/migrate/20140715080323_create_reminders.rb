class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.string :name
      t.datetime :time
      t.integer :method
      t.integer :mode
      t.references :folder, index: true

      t.timestamps
    end
  end
end
