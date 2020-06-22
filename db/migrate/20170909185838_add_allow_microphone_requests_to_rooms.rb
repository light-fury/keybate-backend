class AddAllowMicrophoneRequestsToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :allow_microphone_requests, :bool, default: true
  end
end
