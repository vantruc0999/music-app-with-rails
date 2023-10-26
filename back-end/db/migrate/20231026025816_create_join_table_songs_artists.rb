class CreateJoinTableSongsArtists < ActiveRecord::Migration[7.1]
  def change
    create_table :song_artists do |t|
      t.references :song, null: false, foreign_key: true
      t.references :artist, null: false, foreign_key: true
      t.index [:song_id, :artist_id], unique: true
      t.timestamps
    end
  end
end
