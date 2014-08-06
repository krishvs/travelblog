class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.datetime :date_time
      t.string :name
      t.integer :itenary_id
      t.text :short_description

      t.timestamps
    end
  end
end
