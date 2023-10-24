class CreateAlbums < ActiveRecord::Migration[7.1]
  def change
    create_table :albums do |t|
      t.bigint :artist_id
      t.string :name

      t.timestamps
    end
  end
end
