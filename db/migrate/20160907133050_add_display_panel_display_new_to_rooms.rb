class AddDisplayPanelDisplayNewToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :display_panel_display_new, :bool, default: true
  end
end
