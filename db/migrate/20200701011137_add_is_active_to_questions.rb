class AddIsActiveToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :is_active, :boolean
  end
end
