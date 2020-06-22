class AddIndexesFromPollAnswers < ActiveRecord::Migration[5.0]
  def change
    add_index :poll_answers, :poll_id
    add_index :poll_answers, :user_id
  end
end
