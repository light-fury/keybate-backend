class CreatePollOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :poll_options, id: :uuid do |t|
      t.text :description
      t.references :poll, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
