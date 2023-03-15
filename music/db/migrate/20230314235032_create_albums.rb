class CreateAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :albums do |t|
      t.string :title, null: false
      t.integer :yr, null: false 
      t.string :type, null: false 
      t.references :band, null: false, foreign_key: true
      t.timestamps
    end
  end
end
