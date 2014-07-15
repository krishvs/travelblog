class CreateCosts < ActiveRecord::Migration
  def change
    create_table :costs do |t|
      t.string :item
      t.float :price
      t.float :count
      t.references :folder, index: true
      t.integer :mode
      t.text :description
      t.datetime :date

      t.timestamps
    end
  end
end
