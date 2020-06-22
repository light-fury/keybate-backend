class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts, id: :uuid do |t|
      t.references :event, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
