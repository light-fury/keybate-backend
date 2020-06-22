class AddPinAndDisplayToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :pinnedByModerator, :bool, default: false
    add_column :questions, :displayed, :bool, default: false
  end
end
