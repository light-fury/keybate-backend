class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :room
      t.references :attendee
      t.text :body
      t.datetime :answered_at

      t.timestamps
    end
  end
end
