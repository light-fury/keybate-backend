class AddDisplayedPollToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :displayed_poll, :integer
  end
end
