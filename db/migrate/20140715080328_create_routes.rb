class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.references :folder, index: true
      t.integer :mode
      t.string :start
      t.string :end
      t.text :description

      t.timestamps
    end
  end
end
