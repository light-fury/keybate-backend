class AddAutoAllowQuestionsToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :auto_allow_questions, :boolean, default: true
  end
end
