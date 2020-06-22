json.questions @questions do |question|
  json.partial! "question", question: question
  json.upvoted(@current_user.upvotes.where(question_id: question.id).any?)
end
