class RemoveIsActiveFromQuestions < ActiveRecord::Migration[6.0]
  def change
    remove_column :questions, :is_active, :boolean
  end
end
