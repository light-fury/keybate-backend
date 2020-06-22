json.(notification, :id, :title, :description, :created_at, :read, :event_id, :room_id, :poll_id, :question_id, :contact_id, :message_id)

if notification.message_id.present?
  json.sender do
      json.(notification.message.user, :id, :first_name, :last_name)
  end
end
