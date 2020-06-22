class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages, id: :uuid do |t|
      t.text :body
      t.references :contact, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
