class AddAlbumToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :album, :string
  end
end
