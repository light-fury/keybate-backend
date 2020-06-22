class AddQuestionUnderCallToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :question_under_call, :boolean, default: nil
  end
end
