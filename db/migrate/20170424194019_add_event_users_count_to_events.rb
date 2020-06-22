class AddEventUsersCountToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :event_users_count, :integer, default: 0
  end
end
