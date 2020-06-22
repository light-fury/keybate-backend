class CreateNewQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions, id: :uuid do |t|
      t.text :message
      t.references :room, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end