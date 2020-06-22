json.partial! "profile", user: @user
json.(@user, :first_name, :last_name, :position, :location, :description, :deleted)
json.picture do
  json.thumbnail @user.picture_url_thumbnail
  json.full @user.picture_url_full
end
