class AddEventIdToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_reference :questions, :event, type: :uuid, foreign_key: true
  end
end
