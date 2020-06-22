json.(contact, :id, :event_id, :blocked, :last_message_sent_at, :two_way_contact, :created_at)
json.from_user do
  json.id contact.from_user.id
  json.first_name contact.from_user.first_name
  json.last_name contact.from_user.last_name
  json.location contact.from_user.location
  json.position contact.from_user.position
  json.picture do
    json.thumbnail contact.from_user.picture_url_thumbnail
    json.full contact.from_user.picture_url_full
  end
end
json.to_user do
  json.id contact.to_user.id
  json.first_name contact.to_user.first_name
  json.last_name contact.to_user.last_name
  json.location contact.to_user.location
  json.position contact.to_user.position
  json.picture do
    json.thumbnail contact.to_user.picture_url_thumbnail
    json.full contact.to_user.picture_url_full
  end
end
json.messages contact.messages do |message|
  json.id message.id
  json.body message.body
  json.blocked message.blocked
  json.read message.read
  json.user_id message.user_id
  json.created_at message.created_at
end
