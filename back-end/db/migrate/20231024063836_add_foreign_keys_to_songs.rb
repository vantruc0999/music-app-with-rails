class AddForeignKeysToSongs < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :songs, :artists, column: :artist_id, optional: true
    add_foreign_key :songs, :albums, column: :album_id
  end
end
