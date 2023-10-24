class CreateSongs < ActiveRecord::Migration[7.1]
  def change
    create_table :songs do |t|
      t.string :name
      t.float :duration
      t.integer :release_year
      t.text :lyric, null: true
      t.bigint :play_count, default: 0

      t.bigint :album_id, null:true
      t.bigint :artist_id
      t.timestamps
    end
  end
end
