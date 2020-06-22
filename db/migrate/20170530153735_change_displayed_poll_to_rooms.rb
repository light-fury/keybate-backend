class ChangeDisplayedPollToRooms < ActiveRecord::Migration[5.0]
  def change
    change_column :rooms, :displayed_poll, :string, default: nil
  end
end
