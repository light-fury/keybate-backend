class AddDisplayPanelOptionsToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :dp_background_color, :string
    add_column :rooms, :dp_text_color, :string
    add_column :rooms, :dp_display_kb_logo, :bool, default: true
    add_column :rooms, :dp_display_room_info, :bool, default: true
    add_column :rooms, :dp_display_multiple_questions, :bool, default: false
    add_column :rooms, :dp_display_attendee_info, :bool, default: false
  end
end
