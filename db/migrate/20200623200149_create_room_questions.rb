class CreateRoomQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :room_questions do |t|
      t.integer :room_id
      t.integer :question_id

      t.timestamps
    end
  end
end
