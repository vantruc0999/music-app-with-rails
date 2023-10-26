class RemoveForeignKeyFromSongs < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :songs, :artists, column: :artist_id
  end
end
