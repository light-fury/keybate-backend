json.(question, :id, :message, :displayed, :time_displayed, :hidden, :pinned_to_top, :time_pinned, :sent_to_bottom, :deleted, :upvotes_count, :callable, :allowed, :created_at)
json.updated(!question.upvotes_count.zero?)
json.user do
  json.(question.user, :id, :first_name, :last_name, :position)
  json.picture do
    json.thumbnail question.user.picture_url_thumbnail
    json.full question.user.picture_url_full
  end
end
