class AddIsActiveToRoomQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :room_questions, :is_active, :boolean
  end
end
