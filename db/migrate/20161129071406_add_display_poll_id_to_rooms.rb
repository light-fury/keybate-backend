class AddDisplayPollIdToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :display_panel_current_poll, :integer
  end
end
