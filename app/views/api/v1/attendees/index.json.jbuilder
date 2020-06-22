json.users @users do |user|
  json.(user, :id, :first_name, :last_name, :position, :location, :description)
  json.picture do
    json.thumbnail user.picture_url_thumbnail
    json.full user.picture_url_full
  end
  json.connected_contact_id check_connection(user)
end
