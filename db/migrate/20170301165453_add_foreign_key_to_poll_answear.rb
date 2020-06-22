class AddForeignKeyToPollAnswear < ActiveRecord::Migration[5.0]
  def change
    add_column :poll_answers, :option_id, :uuid
    add_foreign_key :poll_answers, :poll_options,
      column: :option_id, index: true, foreign_key: true
    add_index :poll_answers, :option_id
  end
end
