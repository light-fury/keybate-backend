class AddModeratorRemoveKeyToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :moderator_id, :integer
    remove_column :rooms, :key
  end
end
