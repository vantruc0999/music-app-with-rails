class CreateArtists < ActiveRecord::Migration[7.1]
  def change
    create_table :artists do |t|
      t.string :name
      t.text :information, null: true
      
      t.timestamps
    end
  end
end
