class ChangeTableNameFromQuestions < ActiveRecord::Migration[5.0]
  def change
    rename_table :questions, :old_questions
  end
end
