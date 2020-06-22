json.(poll, :id, :title, :published, :open, :list_order, :display_results)
json.answered answered_by_user(poll)
json.options do
  json.array! poll.options do |option|
    json.option_id option.id
    json.description option.description
    json.count option.answers.count
  end
end
