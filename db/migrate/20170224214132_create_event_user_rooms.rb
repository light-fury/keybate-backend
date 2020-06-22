class CreateEventUserRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :event_user_rooms, id: :uuid do |t|
      t.references :event_user, type: :uuid, foreign_key: true
      t.references :room, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
