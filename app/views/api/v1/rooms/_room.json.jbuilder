json.(room, :id, :name, :color, :question_under_call)
json.attendees do
  json.array! room.event_users do |eur|
    json.id eur.user.id
    json.first_name eur.user.first_name
    json.last_name eur.user.last_name
    json.location eur.user.location
    json.position eur.user.position
    json.picture do
      json.thumbnail eur.user.picture_url_thumbnail
      json.full eur.user.picture_url_full
    end
  end
end
