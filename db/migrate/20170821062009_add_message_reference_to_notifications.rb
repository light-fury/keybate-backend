class AddMessageReferenceToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_reference :notifications, :message, type: :uuid, foreign_key: true
  end
end
