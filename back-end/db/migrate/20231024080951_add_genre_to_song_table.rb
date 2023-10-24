class AddGenreToSongTable < ActiveRecord::Migration[7.1]
  def change
    add_column :songs, :genre_id, :bigint
  end
end
