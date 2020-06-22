class CreateQuestionUpvotes < ActiveRecord::Migration[5.0]
  def change
    create_table :question_upvotes, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.references :question, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
