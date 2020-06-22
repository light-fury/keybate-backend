class AddChartsToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :display_panel_display_poll_bar_chart, :bool, default: false
    add_column :rooms, :display_panel_display_poll_pie_chart, :bool, default: false
  end
end
