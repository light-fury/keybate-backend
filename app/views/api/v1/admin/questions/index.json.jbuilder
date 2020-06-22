json.questions @questions do |question|
  json.partial! "question", question: question
end
