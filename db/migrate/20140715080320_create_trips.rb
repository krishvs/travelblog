class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :name
      t.references :user, index: true
      t.integer :mode
      t.text :description

      t.timestamps
    end
  end
end
