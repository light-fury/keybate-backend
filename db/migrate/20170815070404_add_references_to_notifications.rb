class AddReferencesToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_reference :notifications, :event, type: :uuid, foreign_key: true
    add_reference :notifications, :room, type: :uuid, foreign_key: true
    add_reference :notifications, :poll, type: :uuid, foreign_key: true
    add_reference :notifications, :question, type: :uuid, foreign_key: true
    add_reference :notifications, :contact, type: :uuid, foreign_key: true
  end
end
