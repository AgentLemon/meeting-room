class CreateServerSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :server_settings do |t|
      t.text :token

      t.timestamps
    end
  end
end
