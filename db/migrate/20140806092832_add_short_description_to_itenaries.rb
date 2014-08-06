class AddShortDescriptionToItenaries < ActiveRecord::Migration
  def change
    add_column :itenaries, :short_description, :text
  end
end
