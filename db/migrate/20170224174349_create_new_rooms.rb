class CreateNewRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms, id: :uuid do |t|
      t.string :name
      t.references :event, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
