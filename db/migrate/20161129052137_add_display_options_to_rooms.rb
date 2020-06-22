class AddDisplayOptionsToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :display_panel_display_poll, :bool, default: false
    add_column :rooms, :display_panel_display_poll_results, :bool, default: true
  end
end
