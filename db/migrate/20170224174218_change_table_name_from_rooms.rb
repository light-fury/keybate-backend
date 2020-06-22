class ChangeTableNameFromRooms < ActiveRecord::Migration[5.0]
  def change
    rename_table :rooms, :old_rooms
  end
end
