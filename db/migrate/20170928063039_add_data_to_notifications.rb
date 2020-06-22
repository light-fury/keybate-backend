class AddDataToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :data, :json
  end
end
