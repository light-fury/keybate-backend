class ChangeQuestionUnderCallToString < ActiveRecord::Migration[5.0]
  def change
    change_column :rooms, :question_under_call, :string, default: nil
  end
end
