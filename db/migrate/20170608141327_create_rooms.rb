class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.string :google_id
      t.string :slug
      t.string :name

      t.timestamps
    end

    add_index :rooms, :slug
  end
end
