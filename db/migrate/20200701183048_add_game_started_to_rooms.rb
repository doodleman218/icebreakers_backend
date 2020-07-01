class AddGameStartedToRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :game_started, :boolean
  end
end
