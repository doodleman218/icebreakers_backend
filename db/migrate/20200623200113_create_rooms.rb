class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string :room_name
      t.string :password
      t.integer :host_id

      t.timestamps
    end
  end
end
