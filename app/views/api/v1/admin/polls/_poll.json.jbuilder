json.(poll, :id, :title, :published, :open, :list_order, :display_results)
json.any_answers(poll.answers.any?)
json.options do
  json.array! poll.options do |option|
    json.option_id option.id
    json.description option.description
    json.count option.answers.count
  end
end
