class AddAnswersCountToPolls < ActiveRecord::Migration[5.0]
  def change
    add_column :polls, :answers_count, :integer, default: 0
  end
end
