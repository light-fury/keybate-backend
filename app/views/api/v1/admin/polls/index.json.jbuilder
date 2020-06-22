json.polls @polls do |poll|
  json.partial! "poll", poll: poll
end
