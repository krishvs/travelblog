class CreateDescriptions < ActiveRecord::Migration
  def change
    create_table :descriptions do |t|
      t.references :folder, index: true
      t.text :description
      t.string :title
      t.integer :mode

      t.timestamps
    end
  end
end
