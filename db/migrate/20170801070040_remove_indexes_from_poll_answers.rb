class RemoveIndexesFromPollAnswers < ActiveRecord::Migration[5.0]
  def change
    remove_index :poll_answers, :poll_id
    remove_index :poll_answers, :user_id
  end
end
