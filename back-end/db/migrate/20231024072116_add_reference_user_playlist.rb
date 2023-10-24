class AddReferenceUserPlaylist < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :playlists, :users, column: :user_id, optional: true
  end
end
