class CreatePollAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :poll_answers, id: :uuid do |t|
      t.references :poll, type: :uuid, foreign_key: true, index: false
      t.references :user, type: :uuid, foreign_key: true, index: false

      t.timestamps
    end

    add_index :poll_answers, :poll_id, unique: true
    add_index :poll_answers, :user_id, unique: true
  end
end
