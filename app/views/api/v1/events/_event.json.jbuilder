json.(event, :id, :name, :code, :event_date_start, :event_date_end,
              :description, :category, :location, :practical_information,
              :organizer_contact, :isLive, :event_time_start, :event_time_end)
json.cover event.cover_photo_mobile
json.agendas do
  json.array! event.agendas do |agenda|
    json.agenda_id agenda.id
    json.date agenda.date
    json.time_start agenda.time_start
    json.time_end agenda.time_end
    json.title agenda.title
  end
end
json.speakers do
  json.array! event.speakers do |speaker|
    json.speaker_id speaker.id
    json.name speaker.name
    json.affiliation speaker.affiliation
    json.picture speaker.picture
    json.biography speaker.biography
    json.role speaker.role
  end
end
json.sponsors do
  json.array! event.sponsors do |sponsor|
    json.sponsor_id sponsor.id
    json.name sponsor.name
    json.contact_email sponsor.contact_email
    json.picture sponsor.picture
    json.description sponsor.description
  end
end
json.rooms do
  json.array! event.rooms do |room|
    json.room_id room.id
    json.name room.name
    json.color room.color
  end
end
