class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.integer :mode
      t.references :folder, index: true
      t.text :description

      t.timestamps
    end
  end
end
