class RemoveArtistIdFromSongs < ActiveRecord::Migration[7.1]
  def change
    remove_column :songs, :artist_id, :bigint
  end
end
