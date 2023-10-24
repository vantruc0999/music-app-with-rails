class AddConstraintsToSongPlaylistJoinTable < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :playlists_songs, :songs, column: :song_id
    add_foreign_key :playlists_songs, :playlists, column: :playlist_id
  end
end
