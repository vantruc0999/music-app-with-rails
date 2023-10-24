class AddArtistReferenceToAlbums < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :albums, :artists, column: :artist_id
  end
end
