class AddDisplayedToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :displayed, :boolean, default: false
  end
end
