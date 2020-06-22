class CreatePolls < ActiveRecord::Migration[5.0]
  def change
    create_table :polls, id: :uuid do |t|
      t.string :title
      t.references :room, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
