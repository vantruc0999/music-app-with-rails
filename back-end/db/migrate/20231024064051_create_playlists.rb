class CreatePlaylists < ActiveRecord::Migration[7.1]
  def change
    create_table :playlists do |t|
      t.string :name
      
      t.bigint :user_id

      t.timestamps
    end
  end
end
