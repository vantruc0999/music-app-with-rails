class AddReferenceGenreSong < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :songs, :genres, column: :genre_id
  end
end
