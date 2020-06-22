json.(question, :id, :message, :displayed, :upvotes_count, :deleted)
json.updated(!question.upvotes_count.zero?)
json.user do
  json.(question.user, :id, :first_name, :last_name, :position, :location, :picture_url)
end
