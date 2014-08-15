class AddUrlToMaps < ActiveRecord::Migration
  def change
    add_column :maps, :url, :text
  end
end
