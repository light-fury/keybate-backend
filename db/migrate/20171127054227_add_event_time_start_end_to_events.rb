class AddEventTimeStartEndToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :event_time_start, :time
    add_column :events, :event_time_end, :time
  end
end
