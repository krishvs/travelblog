class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.string :name
      t.integer :mode
      t.references :trip, index: true
      t.float :total_cost
      t.text :description

      t.timestamps
    end
  end
end
