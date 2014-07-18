class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.string :name
      t.integer :mode
      t.text :description
      t.integer :transport

      t.timestamps
    end
  end
end
